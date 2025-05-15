import SwiftUI

struct SignupView: View {
    @Binding var showingSignup: Bool
    @Binding var isLoggedIn: Bool

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var dateOfBirth = ""
    @State private var age = ""

    @State private var signupFailed = false
    @State private var errorMessage = ""

    @EnvironmentObject var db: LoginDatabase

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            HStack {
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding()
            }

            Text("Sign up with Coffee Bond")
                .font(.custom("SnellRoundhand-Bold", size: 28))
                .shadow(radius: 2)

            Group {
                TextField("Enter your first name", text: $firstName)
                TextField("Enter your last name", text: $lastName)
                TextField("Enter your Email Id", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Enter your password", text: $password)
                SecureField("Re-enter your password", text: $confirmPassword)
                TextField("Enter your date of birth", text: $dateOfBirth)
                TextField("Enter your age", text: $age)
                    .keyboardType(.numberPad)
            }
            .padding()
            .background(Color.brown.opacity(0.4))
            .cornerRadius(8)

            Button("Sign Up") {
                if email.isEmpty || password.isEmpty || confirmPassword.isEmpty ||
                    firstName.isEmpty || lastName.isEmpty || dateOfBirth.isEmpty || age.isEmpty {
                    signupFailed = true
                    errorMessage = "Please fill all fields"
                } else if password != confirmPassword {
                    signupFailed = true
                    errorMessage = "Passwords do not match"
                } else if db.users.keys.contains(email) {
                    signupFailed = true
                    errorMessage = "User already exists"
                } else {
                    db.users[email] = LoginUser(
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                        dateOfBirth: dateOfBirth,
                        age: age
                    )
                    db.currentUserEmail = email
                    isLoggedIn = true
                    showingSignup = false
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.brown.opacity(0.6))
            .foregroundColor(.black)
            .font(.title3)
            .cornerRadius(8)

            if signupFailed {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Spacer()

            HStack {
                Text("Already have an account?")
                Button("Login") {
                    showingSignup = false
                }
                .foregroundColor(.blue)
            }
            .font(.custom("SnellRoundhand", size: 18))
        }
        .padding()
        .background(Color("Background"))
    }
}
