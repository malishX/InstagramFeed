import Foundation
import SwiftUI

class PostViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isVideoPlaying = false
    
    let post: Post
    private let cacheService: CacheServiceProtocol
    
    init(post: Post, cacheService: CacheServiceProtocol = CacheService.shared) {
        self.post = post
        self.cacheService = cacheService
        loadMedia()
    }
    
    func loadMedia() {
        guard let media = post.media.first else { return }
        
        if let cachedImage = cacheService.getImage(for: media.url) {
            self.image = cachedImage
            return
        }
        
        if let image = DataService.shared.loadImage(named: media.url) {
            self.image = image
            cacheService.cacheImage(image, for: media.url)
        }
    }
}
