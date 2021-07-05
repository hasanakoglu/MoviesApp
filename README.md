# MoviesApp
An app designed to display the top rated movies using MVVM-C
 - The app stores image data for each cell through image caching
 - Using UserDefaults and encoded JSON to save, delete and retrieve movies added to the favourites section 
 - Each movie has a detailed view which gives an overview and a button which holds a link to the IMDB website
 
 Architecture 
 - The app uses MVVM-C Architecture
 - Designed using UIKit but can easily be changed to SwiftUI and Combine
 - Use of mocks in testing to cover classes with external dependencies in unit tests
 - Test coverage above 93%
 
 Future Improvements
 - Aim to get 100% test coverage
 - Add snapshot testing
 - Add more movies and seperate them into sections through genre
