import Foundation

class PostStore: ObservableObject {
    @Published var posts: [CoffeePost] = []
    
    func addPost(_ post: CoffeePost) {
        posts.insert(post, at: 0) // newest first
    }
}
