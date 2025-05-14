import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var db: LoginDatabase
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let email = db.currentUserEmail,
                   let user = db.users[email] {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\u{1F464} Profile")
                            .font(.largeTitle.bold())
                        Text("First Name: \(user.firstName)")
                        Text("Last Name: \(user.lastName)")
                        Text("Email: \(email)")
                        Text("Date of Birth: \(user.dateOfBirth)")
                        Text("Age: \(user.age)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.brown.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                Spacer()

                Button(action: {
                    db.currentUserEmail = nil
                    isLoggedIn = false // This triggers the switch to LoginView
                }) {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
            .navigationTitle("Profile")
        }
    }
}
