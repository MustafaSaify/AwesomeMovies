//
//  Synchronizer.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol Resource {
    func request() -> URLRequest
    
    associatedtype ParsedObject
    var parse: (Data) throws -> ParsedObject { get }
}

enum SynchronizerResult<Result> {
    case success(Result)
    case noData
    case error(Error)
}

enum SynchronizerError: Error {
    case wrongStatusError(status: Int)
    case urlSessionError(NSError)
}

class Synchronizer {
    
    private lazy var session = self.createSession()
    private func createSession() -> URLSession {
        return URLSession(
            configuration: self.sessionConfiguration,
            delegate: SessionDelegate(cacheTime: self.cacheTime),
            delegateQueue: OperationQueue.main
        )
    }
    private var sessionDelegate: SessionDelegate { return session.delegate as! SessionDelegate }
    private let sessionConfiguration: URLSessionConfiguration
    private let cacheTime: TimeInterval
    
    init(cacheTime: TimeInterval, URLCache: Foundation.URLCache? = URLSessionConfiguration.default.urlCache) {
        self.cacheTime = cacheTime
        self.sessionConfiguration = URLSessionConfiguration.default
        self.sessionConfiguration.urlCache = URLCache
    }
    
    func cancelSession() {
        session.invalidateAndCancel()
        session = createSession()
    }
    
    typealias CancelLoading = () -> Void
    
    func loadResource<R: Resource, Object>
        (_ resource: R, completion: @escaping (SynchronizerResult<Object>) -> ()) -> CancelLoading where R.ParsedObject == Object {
        
        func completeOnMainThread(_ result: SynchronizerResult<Object>) {
            if case .error = result { print(result) }
            OperationQueue.main.addOperation{ completion(result) }
        }
        
        let request = resource.request()
        let task = session.dataTask(with: request)
        print("Request: \(request)")
        sessionDelegate.setCompletionHandlerForTask(task) { (data, response, error) in
            
            guard error?.code != NSURLErrorCancelled else {
                print("Request with URL: \(String(describing: request.url)) was cancelled")
                return // cancel quitely
            }
            
            print("Response: \(String(describing: response))")
            if let result = SynchronizerResult<Object>.resultWithResponse(response, error: error) {
                completeOnMainThread(result)
                return
            }
            
            guard let data = data, data.count > 0 else {
                completeOnMainThread(.noData)
                return
            }
            
            do {
                let object = try resource.parse(data)
                completeOnMainThread(.success(object))
            } catch {
                completeOnMainThread(.error(error))
            }
        }
        task.resume()
        
        return { [weak task] in
            task?.cancel()
        }
    }
}

private extension SynchronizerResult {
    
    static func resultWithResponse(_ response: URLResponse?, error: NSError?) -> SynchronizerResult? {
        guard error == nil else {
            return self.error(SynchronizerError.urlSessionError(error!))
        }
        let statusCode = (response as! HTTPURLResponse).statusCode
        guard 200..<300 ~= statusCode else {
            return self.error(SynchronizerError.wrongStatusError(status: statusCode))
        }
        return nil
    }
}
