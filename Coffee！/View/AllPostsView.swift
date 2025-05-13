import SwiftUI

struct AllPostsView: View {
    @EnvironmentObject var postStore: PostStore

    var body: some View {
        NavigationStack {
            List(postStore.posts) { post in
                HStack(alignment: .top, spacing: 12) {
                    Image(post.photoFilename)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(8)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(post.cafeName)
                            .font(.headline)

                        Text("☕️ \(post.coffeeType)")
                            .font(.subheadline)

                        Text("📅 \(formattedDate(post.date))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Text("⭐️ \(post.cafeRating)")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("All Posts")
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
