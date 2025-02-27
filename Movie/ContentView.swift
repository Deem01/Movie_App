////
////  ContentView.swift
////  Movie
////
////  Created by Deem Ibrahim on 19/01/2025.






import SwiftUI

struct ContentView: View {
    @StateObject private var loginViewModel  = LoginViewModel()
    @State private var isEmailFocused: Bool = false
    @State private var isPasswordInvalid: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // الخلفية
                Image("loginpage") // استبدل بـ اسم الصورة في الـ Assets
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                // المحتوى
                VStack(spacing: 20) {
                    Text("Sign in")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("You'll find what you're looking for in the ocean of movies")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    // حقل البريد الإلكتروني
                    TextField("Email", text: $loginViewModel.email, onEditingChanged: { isEditing in
                        isEmailFocused = isEditing
                    })
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isEmailFocused ? Color.yellow : Color.clear, lineWidth: 2)
                    )
                    .foregroundColor(.white)
                    .autocapitalization(.none)

                    // حقل كلمة المرور
                    SecureField("Password", text: $loginViewModel.password)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isPasswordInvalid ? Color.red : Color.clear, lineWidth: 2)
                        )
                        .foregroundColor(.white)

                    // رسالة خطأ (إذا وجدت)
                    if let errorMessage = loginViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }

                    // زر تسجيل الدخول
                    Button(action: {
                        print("Email: \(loginViewModel.email), Password: \(loginViewModel.password)")
                        if loginViewModel.password.isEmpty {
                            isPasswordInvalid = true
                        } else {
                            isPasswordInvalid = false
                            loginViewModel.login()
                        }
                    }) {
                        Text("Sign in")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(8)
                    }

                    // التنقل إلى صفحة ProfileView عندما يتم تسجيل الدخول بنجاح
//                    NavigationLink(
//                        destination: ProfileView(loginViewModel: loginViewModel), // تأكد من تمرير loginViewModel هنا
//                        isActive: $loginViewModel.isAuthenticated
//                    )
                    NavigationLink(
                                            destination: MoviesView(), // تغيير الوجهة إلى HomeView
                                            isActive: $loginViewModel.isAuthenticated // تغيير الشرط إلى التوثيق
                                        )
                    {
                        EmptyView()
                    }

                }
                .padding(.horizontal, 40)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}















