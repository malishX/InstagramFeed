import Foundation
import UIKit

enum MediaType: String, Codable {
    case image
    case video
}

struct Media: Codable, Identifiable {
    let id: String
    let type: MediaType
    let url: String
    let width: CGFloat
    let height: CGFloat
}
