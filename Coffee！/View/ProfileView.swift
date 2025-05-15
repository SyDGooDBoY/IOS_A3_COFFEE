import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var db: LoginDatabase
    @EnvironmentObject var postStore: PostStore
    @Binding var isLoggedIn: Bool

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

                        // Log Out Button
                        Button(action: {
                            db.currentUserEmail = nil
                            isLoggedIn = false
                            postStore.reset() // Clear calendar data
                        }) {
                            Text("Log Out")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.brown.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top)
            .navigationTitle("Profile")
        }
    }
}
