import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let user: User
    let caption: String?
    let media: [Media]
    let likes: Int
    let timestamp: Date
}
