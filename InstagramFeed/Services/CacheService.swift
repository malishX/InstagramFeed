import UIKit

class CacheService {
    static let shared = CacheService()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private lazy var cacheDirectory: URL = {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("MediaCache")
    }()
    
    private init() {
        setupCacheDirectory()
        memoryCache.countLimit = 100
    }
    
    private func setupCacheDirectory() {
        guard !fileManager.fileExists(atPath: cacheDirectory.path) else { return }
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    func cacheImage(_ image: UIImage, for key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
    
    func getImage(for key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(key)
        guard fileManager.fileExists(atPath: fileURL.path),
              let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        let image = UIImage(data: data)
        if let image = image {
            memoryCache.setObject(image, forKey: key as NSString)
        }
        return image
    }
    
    func clearCache() {
        memoryCache.removeAllObjects()
        try? fileManager.removeItem(at: cacheDirectory)
        setupCacheDirectory()
    }
}
