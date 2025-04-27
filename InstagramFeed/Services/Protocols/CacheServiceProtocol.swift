import UIKit

protocol CacheServiceProtocol {
    func cacheImage(_ image: UIImage, for key: String)
    func getImage(for key: String) -> UIImage?
    func clearCache()
}
