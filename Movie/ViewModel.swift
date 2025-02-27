//
//import SwiftUI
//
//struct Movie: Identifiable {
//    var id: String
//    var name: String
//    var poster: String
//    var story: String
//    var rating: String
//    var IMDb_rating: Double
//    var genre: [String]
//    var runtime: String
//}
//
//
//struct APIResponse: Codable {
//    var records: [Record]
//}
//
//struct Record: Codable {
//    var id: String
//    var fields: Fields
//}
//
//struct Fields: Codable {
//    var name: String
//    var poster: String
//    var story: String
//    var rating: String
//    var IMDb_rating: Double
//    var genre: [String]
//    var runtime: String
//}
//
//struct MoviesView: View {
//    @StateObject var viewModel = MoviesViewModel()
//    @StateObject  var loginViewModel  = LoginViewModel()
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 20) {
//                    // شريط البحث
//                    SearchBar()
//
//                    // قسم "High Rated"
//                    HighRatedSection(movies: viewModel.movies.filter { $0.IMDb_rating >= 9.0 })
//
//                    // قسم "Drama"
//                    GenreSection(title: "Drama", movies: viewModel.movies.filter { $0.genre.contains("Drama") })
//
//                    // قسم "Comedy"
//                    GenreSection(title: "Comedy", movies: viewModel.movies.filter { $0.genre.contains("Comedy") })
//                }
//                .padding()
//            }
//            .background(Color.black)
//            .navigationTitle("Movies Center")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(
//                        destination: ProfileView(loginViewModel: loginViewModel),
//                        isActive: $loginViewModel.isAuthenticated
//
//                    ) {
//                        ProfileIcon()  // This is the icon shown in the navigation bar
//                    }
//                }
//            }
//
//        }
//        .onAppear {
//            Task {
//                await viewModel.fetchMovies()
//            }
//        }
//    }
//}
//
//struct SearchBar: View {
//    @State private var searchText = ""
//
//    var body: some View {
//        HStack {
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(.gray)
//            TextField("Search for Movie name, actors...", text: $searchText)
//                .foregroundColor(.white)
//        }
//        .padding()
//        .background(Color(.darkGray))
//        .cornerRadius(10)
//    }
//}
//
//struct HighRatedSection: View {
//    var movies: [Movie]
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("High Rated")
//                .font(.title2)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 15) {
//                    ForEach(movies) { movie in
//                        HighRatedMovieCard(movie: movie)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct HighRatedMovieCard: View {
//    var movie: Movie
//
//    var body: some View {
//        NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
//            VStack(alignment: .leading, spacing: 10) {
//                AsyncImage(url: URL(string: movie.poster)) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                            .frame(width: 150, height: 200)
//                    case .success(let image):
//                        image.resizable()
//                            .scaledToFit()
//                            .frame(width: 150, height: 200)
//                    case .failure(_):
//                        Image(systemName: "photo")
//                            .frame(width: 150, height: 200)
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//
//                Text(movie.name)
//                    .font(.headline)
//                    .foregroundColor(.white)
//
//                HStack {
//                    Text("⭐️ \(String(format: "%.1f", movie.IMDb_rating))")
//                    Spacer()
//                    Text(movie.rating)
//                }
//                .font(.subheadline)
//                .foregroundColor(.gray)
//
//                Text(movie.genre.joined(separator: ", "))
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Text(movie.runtime)
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//            .padding()
//            .background(Color(.darkGray))
//            .cornerRadius(10)
//        }
//    }
//}
//
//
//struct GenreSection: View {
//    var title: String
//    var movies: [Movie]
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            HStack {
//                Text(title)
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//
//                Spacer()
//
//                Button(action: {}) {
//                    Text("Show more")
//                        .font(.subheadline)
//                        .foregroundColor(.yellow)
//                }
//            }
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 15) {
//                    ForEach(movies) { movie in
//                        GenreMovieCard(movie: movie)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct GenreMovieCard: View {
//    var movie: Movie
//
//    var body: some View {
//        NavigationLink(destination: MovieDetailView(movie: movie)) {
//            VStack(alignment: .leading, spacing: 10) {
//                AsyncImage(url: URL(string: movie.poster)) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                            .frame(width: 100, height: 150)
//                    case .success(let image):
//                        image.resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 150)
//                    case .failure(_):
//                        Image(systemName: "photo")
//                            .frame(width: 100, height: 150)
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//
//                Text(movie.name)
//                    .font(.subheadline)
//                    .foregroundColor(.white)
//            }
//        }
//    }
//}
//
//
//struct ProfileIcon: View {
//    var body: some View {
//        Image(systemName: "person.circle.fill")
//            .resizable()
//            .frame(width: 30, height: 30)
//            .foregroundColor(.white)
//    }
//}
////
////struct MovieDetailView: View {
////    var movie: Movie
////
////    var body: some View {
////        ScrollView {
////            VStack(alignment: .leading, spacing: 10) {
////                AsyncImage(url: URL(string: movie.poster)) { phase in
////                    switch phase {
////                    case .empty:
////                        ProgressView()
////                            .frame(height: 300)
////                    case .success(let image):
////                        image.resizable()
////                            .scaledToFit()
////                            .frame(height: 300)
////                    case .failure(_):
////                        Image(systemName: "photo")
////                            .frame(height: 300)
////                    @unknown default:
////                        EmptyView()
////                    }
////                }
////
////                Text(movie.name)
////                    .font(.title)
////                    .fontWeight(.bold)
////                    .foregroundColor(.white)
////
////                HStack {
////                    Text("⭐️ \(String(format: "%.1f", movie.IMDb_rating))")
////                        .font(.subheadline)
////                        .foregroundColor(.yellow)
////                    Spacer()
////                    Text(movie.runtime)
////                        .font(.subheadline)
////                        .foregroundColor(.gray)
////                }
////
////                Text(movie.genre.joined(separator: ", "))
////                    .font(.subheadline)
////                    .foregroundColor(.gray)
////
////                Text(movie.story)
////                    .font(.body)
////                    .foregroundColor(.white)
////                    .padding(.top, 10)
////
////                Spacer()
////            }
////            .padding()
////        }
////        .background(Color.black)
////        .navigationTitle(movie.name)
////        .navigationBarTitleDisplayMode(.inline)
////    }
////}
//
//
//class MoviesViewModel: ObservableObject {
//    @Published var movies: [Movie] = []
//    @Published var directors: [Director] = []
//    @Published var actors: [Actor] = []
//   
//    func fetchMovies() async {
//        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/movies") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
//
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            if let httpResponse = response as? HTTPURLResponse {
//                print("Response status code: \(httpResponse.statusCode)")
//            }
//
//            if data.isEmpty {
//                print("No data received.")
//                return
//            }
//
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Response data: \(jsonString)")
//            }
//
//            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//
//            DispatchQueue.main.async {
//                self.movies = decodedResponse.records.map { record in
//                    Movie(
//                        id: record.id,
//                        name: record.fields.name,
//                        poster: record.fields.poster,
//                        story: record.fields.story,
//                        rating: record.fields.rating,
//                        IMDb_rating: record.fields.IMDb_rating,
//                        genre: record.fields.genre,
//                        runtime: record.fields.runtime
//                    )
//                }
//            }
//        } catch {
//            print("Error fetching or decoding data: \(error)")
//        }
//    }
//    // تعديل fetchDirectors
//    func fetchDirectors() async {
//        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/directors") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            
//            // طباعة البيانات المستردة
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Directors API Response: \(jsonString)")
//            }
//            
//            let decodedResponse = try JSONDecoder().decode(DirectorAPIResponse.self, from: data)
//            DispatchQueue.main.async {
//                self.directors = decodedResponse.records.compactMap { record in
//                    guard let name = record.fields.name else { return nil }
//                    return Director(id: record.id, name: name, photo: record.fields.photo ?? "")  // استخدم القيمة الفارغة إذا لم يكن هناك photo
//                }
//            }
//        } catch {
//            print("Error fetching directors: \(error)")
//        }
//    }
//
//
//    func fetchActors() async {
//        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/actors") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let decodedResponse = try JSONDecoder().decode(ActorAPIResponse.self, from: data)
//            DispatchQueue.main.async {
//                self.actors = decodedResponse.records.compactMap { record in
//                    Actor(id: record.id, name: record.fields.name ?? "Unknown", photo: record.fields.photo ?? "") // استخدام "Unknown" في حال كانت name مفقودة
//                }
//            }
//        } catch {
//            print("Error fetching actors: \(error)")
//        }
//    }
//
//    func fetchMovieActors(movieId: String) async -> [Actor] {
//        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/movie_actors?filterByFormula=movie_id=\"\(movieId)\"") else { return [] }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let decodedResponse = try JSONDecoder().decode(ActorAPIResponse.self, from: data)
//            return decodedResponse.records.map { record in
//                Actor(id: record.id, name: record.fields.name, photo: record.fields.photo)
//            }
//        } catch {
//            print("Error fetching movie actors: \(error)")
//            return []
//        }
//    }
//}

import SwiftUI

struct Movie: Identifiable {
    var id: String
    var name: String
    var poster: String
    var story: String
    var rating: String
    var IMDb_rating: Double
    var genre: [String]
    var runtime: String
}

struct APIResponse: Codable {
    var records: [Record]
}

struct Record: Codable {
    var id: String
    var fields: Fields
}

struct Fields: Codable {
    var name: String
    var poster: String
    var story: String
    var rating: String
    var IMDb_rating: Double
    var genre: [String]
    var runtime: String
}

struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // شريط البحث
                    SearchBar()

                    // قسم "High Rated"
                    HighRatedSection(movies: viewModel.movies.filter { $0.IMDb_rating >= 9.0 })

                    // قسم "Drama"
                    GenreSection(title: "Drama", movies: viewModel.movies.filter { $0.genre.contains("Drama") })

                    // قسم "Comedy"
                    GenreSection(title: "Comedy", movies: viewModel.movies.filter { $0.genre.contains("Comedy") })
                }
                .padding()
            }
            .background(Color.black)
            .navigationTitle("Movies Center")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: ProfileView(loginViewModel: loginViewModel),
                        isActive: $loginViewModel.isAuthenticated
                    ) {
                        ProfileIcon()  // This is the icon shown in the navigation bar
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMovies()
            }
        }
    }
}

struct SearchBar: View {
    @State private var searchText = ""

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search for Movie name, actors...", text: $searchText)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color(.darkGray))
        .cornerRadius(10)
    }
}

struct HighRatedSection: View {
    var movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("High Rated")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(movies) { movie in
                        HighRatedMovieCard(movie: movie)
                    }
                }
            }
        }
    }
}

struct HighRatedMovieCard: View {
    var movie: Movie

    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie, viewModel: MoviesViewModel())) {  // تم إضافة `viewModel`
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: movie.poster)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 150, height: 200)
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 200)
                    case .failure(_):
                        Image(systemName: "photo")
                            .frame(width: 150, height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(movie.name)
                    .font(.headline)
                    .foregroundColor(.white)

                HStack {
                    Text("⭐️ \(String(format: "%.1f", movie.IMDb_rating))")
                    Spacer()
                    Text(movie.rating)
                }
                .font(.subheadline)
                .foregroundColor(.gray)

                Text(movie.genre.joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(movie.runtime)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.darkGray))
            .cornerRadius(10)
        }
    }
}

struct GenreSection: View {
    var title: String
    var movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()

                Button(action: {}) {
                    Text("Show more")
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(movies) { movie in
                        GenreMovieCard(movie: movie)
                    }
                }
            }
        }
    }
}

struct GenreMovieCard: View {
    var movie: Movie

    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie, viewModel: MoviesViewModel())) {  // تم إضافة `viewModel`
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: movie.poster)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 150)
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                    case .failure(_):
                        Image(systemName: "photo")
                            .frame(width: 100, height: 150)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(movie.name)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ProfileIcon: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
    }
}

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var directors: [Director] = []
    @Published var actors: [Actor] = []

    @Published var reviews: [Review] = []  // نشر المراجعات هنا
    
    // جلب المراجعات الخاصة بالفيلم
    
    func fetchMovies() async {
        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/movies") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }

            if data.isEmpty {
                print("No data received.")
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response data: \(jsonString)")
            }

            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)

            DispatchQueue.main.async {
                self.movies = decodedResponse.records.map { record in
                    Movie(
                        id: record.id,
                        name: record.fields.name,
                        poster: record.fields.poster,
                        story: record.fields.story,
                        rating: record.fields.rating,
                        IMDb_rating: record.fields.IMDb_rating,
                        genre: record.fields.genre,
                        runtime: record.fields.runtime
                    )
                }
            }
        } catch {
            print("Error fetching or decoding data: \(error)")
        }
    }

    func fetchDirectors() async {
        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/directors") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(DirectorAPIResponse.self, from: data)
            DispatchQueue.main.async {
                self.directors = decodedResponse.records.compactMap { record in
                    guard let name = record.fields.name else { return nil }
                    return Director(id: record.id, name: name, image: record.fields.photo ?? "")
                }
            }
        } catch {
            print("Error fetching directors: \(error)")
        }
    }

    func fetchActors() async {
        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/actors") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ActorAPIResponse.self, from: data)
            DispatchQueue.main.async {
                self.actors = decodedResponse.records.compactMap { record in
                    guard let name = record.fields.name else { return nil }
                    return Actor(id: record.id, name: name, photo: record.fields.photo ?? "")
                }
            }
        } catch {
            print("Error fetching actors: \(error)")
        }
    };func fetchReviews(movieId: String) async {
        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/reviews?filterByFormula='\(movieId)'") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ReviewAPIResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.reviews = decodedResponse.records.map { record in
                    Review(
                        id: record.id,
                        rate: record.fields.rate,
                        reviewText: record.fields.review_text,
                        movieId: record.fields.movie_id,
                        userId: record.fields.user_id
                    )
                }
            }
        } catch {
            print("Error fetching reviews: \(error)")
        }
    }

    func fetchMovieDirectors(movieId: String) async -> [Director] {
        // هنا يمكنك إضافة الكود الخاص بجلب المخرجين المرتبطين بالفيلم
        return directors
    }

    func fetchMovieActors(movieId: String) async -> [Actor] {
        // هنا يمكنك إضافة الكود الخاص بجلب الممثلين المرتبطين بالفيلم
        return actors
    }
}

struct Director: Identifiable {
    var id: String
    var name: String
    var image: String
}

struct Actor: Identifiable {
    var id: String
    var name: String
    var photo: String
}

struct DirectorAPIResponse: Codable {
    var records: [DirectorRecord]
}

struct DirectorRecord: Codable {
    var id: String
    var fields: DirectorFields
}
struct DirectorFields: Codable {
    var name: String?
    var photo: String?  // اجعلها اختياريّة بدلاً من غير اختياريّة
}

struct ActorFields: Codable {
    var name: String?
    var photo: String?  // اجعلها اختياريّة بدلاً من غير اختياريّة
}


struct ActorAPIResponse: Codable {
    var records: [ActorRecord]
}

struct ActorRecord: Codable {
    var id: String
    var fields: ActorFields
}


struct MovieDetailView: View {
    var movie: Movie
    @ObservedObject var viewModel: MoviesViewModel

    @State  var movieDirectors: [Director] = []
    @State  var movieActors: [Actor] = []
        @State private var movieReviews: [Review] = [] 
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: movie.poster)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    case .failure(_):
                        Image(systemName: "photo")
                            .frame(height: 300)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(movie.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                HStack {
                    Text("⭐️ \(String(format: "%.1f", movie.IMDb_rating))")
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                    Spacer()
                    Text(movie.runtime)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Text(movie.genre.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(movie.story)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.top, 10)

                // عرض المخرج
                if !movieDirectors.isEmpty {
                    Text("Director")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    ForEach(movieDirectors) { director in
                        HStack {
                            AsyncImage(url: URL(string: director.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                case .failure(_):
                                    Text("Failed to load")
                                        .foregroundColor(.red)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            Text(director.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                        }
                    }
                }

                // عرض الممثلين
                if !movieActors.isEmpty {
                    Text("Cast")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(movieActors) { actor in
                                VStack {
                                    AsyncImage(url: URL(string: actor.photo)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        case .success(let image):
                                            image.resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        case .failure(_):
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    Text(actor.name)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    
                                }
                            }
                        }
                    }
                }

                if !movieReviews.isEmpty {
                    Text("Reviews")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    ForEach(movieReviews) { review in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Rating: \(review.rate, specifier: "%.1f")")
                                    .font(.subheadline)
                                    .foregroundColor(.yellow)
                                Spacer()
                            }
                            Text(review.reviewText)
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)
                        .background(Color(.darkGray))
                        .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .background(Color.black)
        .navigationTitle(movie.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.fetchDirectors()
                await viewModel.fetchActors()
                movieDirectors = await viewModel.fetchMovieDirectors(movieId: movie.id)
                movieActors = await viewModel.fetchMovieActors(movieId: movie.id)
                await viewModel.fetchReviews(movieId: movie.id)  // تحميل المراجعات
                movieReviews = viewModel.reviews 
            }
        }
    }
}

struct Review: Identifiable {
    var id: String
    var rate: Double
    var reviewText: String
    var movieId: String
    var userId: String
}

struct ReviewAPIResponse: Codable {
    var records: [ReviewRecord]
}

struct ReviewRecord: Codable {
    var id: String
    var fields: ReviewFields
}

struct ReviewFields: Codable {
    var rate: Double
    var review_text: String
    var movie_id: String
    var user_id: String
}

//
//struct MovieDetailView: View {
//    var movie: Movie
//    @ObservedObject var viewModel: MoviesViewModel
//    @State private var movieDirectors: [Director] = []
//    @State private var movieActors: [Actor] = []
//    @State private var movieReviews: [Review] = []  // إضافة المتغير للمراجعات
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 10) {
//                // عرض صورة الفيلم
//                AsyncImage(url: URL(string: movie.poster)) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                            .frame(height: 300)
//                    case .success(let image):
//                        image.resizable()
//                            .scaledToFit()
//                            .frame(height: 300)
//                    case .failure(_):
//                        Image(systemName: "photo")
//                            .frame(height: 300)
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//
//                Text(movie.name)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//
//                HStack {
//                    Text("⭐️ \(String(format: "%.1f", movie.IMDb_rating))")
//                        .font(.subheadline)
//                        .foregroundColor(.yellow)
//                    Spacer()
//                    Text(movie.runtime)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//
//                Text(movie.genre.joined(separator: ", "))
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//
//                Text(movie.story)
//                    .font(.body)
//                    .foregroundColor(.white)
//                    .padding(.top, 10)
//
//                // عرض المراجعات
//                if !movieReviews.isEmpty {
//                    Text("Reviews")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding(.top, 10)
//
//                    ForEach(movieReviews) { review in
//                        VStack(alignment: .leading, spacing: 10) {
//                            HStack {
//                                Text("Rating: \(review.rate, specifier: "%.1f")")
//                                    .font(.subheadline)
//                                    .foregroundColor(.yellow)
//                                Spacer()
//                            }
//                            Text(review.reviewText)
//                                .font(.body)
//                                .foregroundColor(.white)
//                        }
//                        .padding(.vertical, 10)
//                        .background(Color(.darkGray))
//                        .cornerRadius(10)
//                    }
//                }
//
//                Spacer()
//            }
//            .padding()
//        }
//        .background(Color.black)
//        .navigationTitle(movie.name)
//        .navigationBarTitleDisplayMode(.inline)
//        .onAppear {
//            Task {
//                await viewModel.fetchDirectors()
//                await viewModel.fetchActors()
//                movieDirectors = await viewModel.fetchMovieDirectors(movieId: movie.id)
//                movieActors = await viewModel.fetchMovieActors(movieId: movie.id)
//                await viewModel.fetchReviews(movieId: movie.id)  // تحميل المراجعات
//                movieReviews = viewModel.reviews  // تحديث المراجعات
//            }
//        }
//    }
//}
//
//struct Review: Identifiable {
//    var id: String
//    var rate: Double
//    var reviewText: String
//    var movieId: String
//    var userId: String
//}
//
//struct ReviewAPIResponse: Codable {
//    var records: [ReviewRecord]
//}
//
//struct ReviewRecord: Codable {
//    var id: String
//    var fields: ReviewFields
//}
//
//struct ReviewFields: Codable {
//    var rate: Double
//    var review_text: String
//    var movie_id: String
//    var user_id: String
//}
//class MoviesViewModel: ObservableObject {
//    @Published var movies: [Movie] = []
//    @Published var directors: [Director] = []
//    @Published var actors: [Actor] = []
//    @Published var reviews: [Review] = []  // نشر المراجعات هنا
//    
//    // جلب المراجعات الخاصة بالفيلم
//    func fetchReviews(movieId: String) async {
//        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/reviews?filterByFormula='\(movieId)'") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Bearer your_api_key", forHTTPHeaderField: "Authorization")
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let decodedResponse = try JSONDecoder().decode(ReviewAPIResponse.self, from: data)
//            
//            DispatchQueue.main.async {
//                self.reviews = decodedResponse.records.map { record in
//                    Review(
//                        id: record.id,
//                        rate: record.fields.rate,
//                        reviewText: record.fields.review_text,
//                        movieId: record.fields.movie_id,
//                        userId: record.fields.user_id
//                    )
//                }
//            }
//        } catch {
//            print("Error fetching reviews: \(error)")
//        }
//    }
//}
