//
//  LoginView.swift
//  Coffee！
//
//  Created by AJ on 14/5/2025.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var loginFailed = false
    @State private var showingSignup = false

    @EnvironmentObject var db: LoginDatabase

    var body: some View {
        if showingSignup {
            SignupView(showingSignup: $showingSignup, isLoggedIn: $isLoggedIn)
                .environmentObject(db)
        } else {
            VStack(spacing: 24) {
                HStack {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                }

                Text("Login with Coffee Bond")
                    .font(.custom("Zapfino", size: 20))
                    .shadow(radius: 1)
                    .padding(.top, 10)

                HStack {
                    Image(systemName: "envelope")
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding()
                .background(Color.brown.opacity(0.3))
                .cornerRadius(8)

                HStack {
                    Image(systemName: "lock")
                    SecureField("Enter your password", text: $password)
                }
                .padding()
                .background(Color.brown.opacity(0.3))
                .cornerRadius(8)

                Button("Login") {
                    if db.users[email]?.password == password {
                        db.currentUserEmail = email
                        isLoggedIn = true
                    } else {
                        loginFailed = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.brown.opacity(0.6))
                .foregroundColor(.black)
                .font(.title3)
                .cornerRadius(8)

                if loginFailed {
                    Text("Incorrect email or password")
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Spacer()

                HStack {
                    Text("Don’t have an account?")
                    Button("Sign up") {
                        showingSignup = true
                    }
                    .foregroundColor(.blue)
                }
                .font(.custom("SnellRoundhand", size: 20))
            }
            .padding()
            .background(Color("Background"))
        }
    }
}
