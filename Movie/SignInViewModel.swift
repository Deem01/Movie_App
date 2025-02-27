//
//  SignInViewModel.swift
//  Movie
//
//  Created by Deem Ibrahim on 19/01/2025.
//


import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String? = nil
    @Published var profileImageURL: String? // رابط صورة البروفايل
    @Published var username: String? // اسم المستخدم

    func login() {
        guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error. Please try again."
                }
                return
            }
            
            do {
                // Parse response data
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let records = json["records"] as? [[String: Any]] {
                    let validUser = records.first(where: { record in
                        if let fields = record["fields"] as? [String: Any],
                           let userEmail = fields["email"] as? String,
                           let userPassword = fields["password"] as? String {
                            return userEmail == self.email && userPassword == self.password
                        }
                        return false
                    })
                    
                    DispatchQueue.main.async {
                        if validUser != nil {
                            self.isAuthenticated = true
                            if let fields = validUser?["fields"] as? [String: Any] {
                                self.username = fields["name"] as? String
                                self.profileImageURL = fields["profile_image"] as? String // إضافة الرابط هنا
                            }
                        } else {
                            self.errorMessage = "Invalid email or password."
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Unexpected server response."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to parse server response."
                }
            }
        }
        
        task.resume()
    }
}

