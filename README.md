# MoviesApp
<img width="200" alt="Screenshot 2021-07-05 at 14 33 34" src="https://user-images.githubusercontent.com/31506037/124479319-0f86dd00-dd9e-11eb-9d93-183d4c39ccd4.png">


An app designed to display the top rated movies using MVVM-C
 - The app stores image data for each cell through image caching
 - Using UserDefaults and encoded JSON to save, delete and retrieve movies added to the favourites section 
 - Each movie has a detailed view which gives an overview and a button which holds a link to the IMDB website
 
 Architecture 
 - The app uses MVVM-C Architecture with dependency injection and testing
 - Designed using UIKit but can easily be changed to SwiftUI and Combine
 - Use of mocks in testing to cover classes with external dependencies for unit tests
 
 Future Improvements
 - Add snapshot testing
 - Add more movies and seperate them into sections through genre
