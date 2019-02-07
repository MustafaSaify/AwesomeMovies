//
//  MovieFilterTableViewController.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

protocol MovieFilterViewControllerInput {
    func displayPicker(viewModel: MovieFilter.Pick.ViewModel)
    func displayRecordedItem(viewModel: MovieFilter.Record.ViewModel)
}

protocol MovieFilterViewControllerOutput {
    var filterDetails: MovieFilterDetails! { get set }
    func listFilterItems()
    func pick(request: MovieFilter.Pick.Request)
    func record(request: MovieFilter.Record.Request)
    func clearFilter()
}

class MovieFilterViewController: UIViewController {
    
    var output: MovieFilterViewControllerOutput!
    var router: MovieFilterRouter!
    fileprivate lazy var items: [MovieFilterItemViewModel] = []
    fileprivate lazy var pickerItems: [String] = []
    fileprivate var selectedItem: FilterItem?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerTitleButton: UIBarButtonItem!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MovieFilterConfigurator.instance.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MovieFilterConfigurator.instance.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFilterItemsOnLoad()
        configureNavigationBar()
    }
    
    fileprivate func loadFilterItemsOnLoad() {
        output.listFilterItems()
    }
    
    fileprivate func configureNavigationBar() {
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear(sender:)))
        navigationItem.leftBarButtonItem = clear
        
        let dismiss = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismiss(sender:)))
        navigationItem.rightBarButtonItem = dismiss
    }
    
    @objc fileprivate func clear(sender: Any?) {
        output.clearFilter()
    }
    
    @objc fileprivate func dismiss(sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickerDone(sender: Any?) {
        let row = picker.selectedRow(inComponent: 0)
        if let selectedItem = selectedItem {
            output.record(request: MovieFilter.Record.Request(item: selectedItem, value: pickerItems[row]))
        }
        dismissPicker()
    }
    
    @IBAction func pickerCancel(sender: Any?) {
        dismissPicker()
    }
    
    @IBAction func apply(sender: Any?) {
        router.passDataToMovieList()
        dismiss(sender: sender)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissPicker()
    }
    
    fileprivate func dismissPicker() {
        pickerContainerView.isHidden = true
    }
    
    fileprivate func displayError(with title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension MovieFilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieFilterItemCell", for: indexPath)
        let viewModel = items[indexPath.row]
        cell.textLabel?.text = viewModel.titleText
        cell.detailTextLabel?.text = viewModel.detailsText
        return cell
    }
}

extension MovieFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        output.pick(request: MovieFilter.Pick.Request(item: item.itemType))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Filter by release year"
    }
}

extension MovieFilterViewController: MovieFilterViewControllerInput {
    
    func displayFilterItems(viewModel: MovieFilter.List.ViewModel) {
        items = viewModel.items
        tableView.reloadData()
    }
    
    func displayPicker(viewModel: MovieFilter.Pick.ViewModel) {
        pickerItems = viewModel.pickerItems
        picker.reloadAllComponents()
        if let selectedRow = viewModel.selectedIndex {
            picker.selectRow(selectedRow, inComponent: 0, animated: true)
        }
        pickerContainerView.isHidden = false
        pickerTitleButton.title = viewModel.item.title
        selectedItem = viewModel.item
    }
    
    func displayRecordedItem(viewModel: MovieFilter.Record.ViewModel) {
        if let error = viewModel.error {
            displayError(with: "Error", message: error)
        }
        else {
            guard let index = items.firstIndex(where: { $0.itemType == viewModel.item }) else { return }
            items[index].value = viewModel.recordedValue
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension MovieFilterViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }
}

extension MovieFilterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if let selectedItem = selectedItem {
//            output.record(request: MovieFilter.Record.Request(item: selectedItem, value: pickerItems[row]))
//        }
    }
}
