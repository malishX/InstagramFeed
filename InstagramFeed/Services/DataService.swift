import Foundation
import UIKit

final class DataService: DataServiceProtocol {  // Add ": DataServiceProtocol"
    static let shared = DataService()
    
    private init() {}
    
    func loadPosts() -> [Post] {
        guard let url = Bundle.main.url(forResource: "mockData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let posts = try decoder.decode([Post].self, from: data)
            return posts
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
    
    func loadImage(named: String) -> UIImage? {  // Correct spelling
        return UIImage(named: named)
    }
}
