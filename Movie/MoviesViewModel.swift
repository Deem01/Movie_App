
import SwiftUI

struct ProfileView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @State var user: gituser?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Header Section
                headerSection
                // Saved Movies Section
                savedMoviesSection
            }
            .background(Color.black)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
            .task {
                do {
                    user = try await getUser()
                } catch {
                    print("خطأ أثناء تحميل البيانات: \(error)")
                }
            }
        }
    }

    // Header Section
    var headerSection: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { phase in
                self.asyncImageView(for: phase)
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(loginViewModel.username ?? "?????")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(loginViewModel.email ?? "?????")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .padding(.horizontal)
    }

    // Saved Movies Section
    var savedMoviesSection: some View {
        VStack {
            HStack {
                Text("Saved movies")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack {
                Image(systemName: "video.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                Text("No saved movies yet, start save \nyour favourites")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // Helper function to display AsyncImage content
    func asyncImageView(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            return AnyView(ProgressView().frame(width: 60, height: 60))
        case .success(let image):
            return AnyView(image.resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle()))
        case .failure(_):
            return AnyView(Circle().foregroundColor(.gray).frame(width: 60, height: 60))
        @unknown default:
            return AnyView(EmptyView())
        }
    }

    func getUser() async throws -> gituser {
        let endpoint = "https://example.com/api/user" // هذا رابط عينة فقط
        guard let url = URL(string: endpoint) else { throw ghe.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ghe.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(gituser.self, from: data)
        } catch {
            throw ghe.invalidData
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(loginViewModel: LoginViewModel()) // إضافة loginViewModel هنا
    }
}

struct gituser: Codable {
    let name: String
    let avatarUrl: String
    let email: String
}

enum ghe: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}


