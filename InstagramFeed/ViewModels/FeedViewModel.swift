import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = DataService.shared) {
        self.dataService = dataService
        loadPosts()
    }
    
    func loadPosts() {
        isLoading = true
        posts = dataService.loadPosts()
        isLoading = false
    }
}
