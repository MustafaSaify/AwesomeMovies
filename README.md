# AwsomeMovies App

The app fetches and displays the movies based on min and max release year using the TMDB APIs.


## Code Overview

The code is implemented in below layers

- Network Layer (Responsible for making network request)
- Data Access Layer (Responsible for providing data in pages)
- User Interface (Responsible for displaying data)

The app consists of below modules

- Scenes:
    - Movies List - Fetches and displays movie based on the selected min and max year.
    - Movies Filter - Allows the user to specify the min and max release year so as to fetch the movies released during the selected duration.
    - Movie Details - Fetches and displays details for a movie. (poster, name, tagline, duration, genre, ratings and description)

- Networking Module : 
    - Responsible for making network request.

- Data Access Module : 
    - Responsible for fetching data in pages.
    
- Image Access Module : 
    - Downloading and caching poster image for a movie.



## Architecture Design Pattern

The app is architected using the Clean Architecture VIP  (View Interactor Presenter) along with Protocol Oriented Programming.
VIP + Protocol Oriented Programming using Generics.



## Testability

- Tests for Movie list service/network layer.   


## Future Enhancements:

- Better test coverage.
- The app downloads the poster of a fixed size w500 which could be made dynamic to use the size of the image view.
- iPad compatibility.
