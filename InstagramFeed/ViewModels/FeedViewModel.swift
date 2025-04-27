import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = DataService.shared) {
        self.dataService = dataService
        loadPosts()
    }
    
    func loadPosts() {
        isLoading = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let posts = self.dataService.loadPosts()
            
            DispatchQueue.main.async {
                self.posts = posts
                self.isLoading = false
            }
        }
    }
}
