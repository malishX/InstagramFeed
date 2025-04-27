import Foundation
import UIKit

protocol DataServiceProtocol {
    func loadPosts() -> [Post]
    func loadImage(named: String) -> UIImage?
}
