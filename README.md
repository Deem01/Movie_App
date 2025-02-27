# 🎬 Movie App - iOS SwiftUI

## 📝 Description

This is a movie app built with **SwiftUI** for iOS. It uses **Postman** API to fetch and display a variety of movie data including high-rated movies, movie genres, directors, actors, and user reviews.

## 🌟 Features

- **User Authentication**: Sign in and view the user profile.
- **Movie Listing**: Displays movies filtered by high ratings and genres.
- **Movie Details**: Detailed information about each movie, including cast, directors, and reviews.
- **Search**: Search for movies by name, actors, and more.

## 🛠️ Technologies Used

- **SwiftUI**: For the user interface.
- **Postman API**: For fetching movie data, including details such as ratings, genres, and reviews.
- **Asynchronous Data Fetching**: Used `async/await` to load data from the Postman API.

## ⚡ How to Run the App

1. Clone this repository to your local machine.
2. Open the project in **Xcode**.
3. Build and run the app on a simulator or device.
4. The app will display the **Movies Center** interface with movie data fetched from Postman API.

## 🔗 API Integration

This app integrates with the Postman API to fetch movie data, including:

- **Movies API**: Fetches movie details such as name, rating, poster, story, genre, and runtime.
- **Directors API**: Fetches directors associated with each movie.
- **Actors API**: Fetches actors associated with each movie.
- **Reviews API**: Fetches user reviews for each movie.

## 🧩 API Methodology and Tools

- **Postman API**: The API was tested and integrated using **Postman** to fetch data from a live source. 
- **URLSession**: Used `URLSession` for making asynchronous HTTP requests.
- **JSONDecoder**: Used to decode JSON data into **Swift** structs for easy use within the app.

### 🌐 Example API URL:

- **Movies API**: `https://api.airtable.com/v0/appsfcB6YESLj4NCN/movies`
- **Directors API**: `https://api.airtable.com/v0/appsfcB6YESLj4NCN/directors`
- **Actors API**: `https://api.airtable.com/v0/appsfcB6YESLj4NCN/actors`
- **Reviews API**: `https://api.airtable.com/v0/appsfcB6YESLj4NCN/reviews`


## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
