import SwiftUI

struct PostView: View {
    @StateObject var viewModel: PostViewModel
    @State private var isVideoPlaying = false
    
    init(post: Post) {
        _viewModel = StateObject(wrappedValue: PostViewModel(post: post))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            mediaView
            actionButtons
            likesView
            captionView
            timestampView
        }
    }
    
    private var headerView: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            
            Text(viewModel.post.user.username)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
    }
    
    private var mediaView: some View {
        Group {
            if let media = viewModel.post.media.first {
                MediaView(media: media,
                         image: viewModel.image,
                         isVideoPlaying: $isVideoPlaying)
            }
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 16) {
            Button(action: {}) {
                Image(systemName: "heart")
                    .font(.system(size: 24))
            }
            
            Button(action: {}) {
                Image(systemName: "message")
                    .font(.system(size: 24))
            }
            
            Button(action: {}) {
                Image(systemName: "paperplane")
                    .font(.system(size: 24))
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "bookmark")
                    .font(.system(size: 24))
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
    }
    
    private var likesView: some View {
        Text("\(viewModel.post.likes) likes")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.bottom, 2)
    }
    
    private var captionView: some View {
        Group {
            if let caption = viewModel.post.caption {
                HStack(alignment: .top, spacing: 4) {
                    Text(viewModel.post.user.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(caption)
                        .font(.subheadline)
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
        }
    }
    
    private var timestampView: some View {
        Text(viewModel.post.timestamp, style: .date)
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.horizontal, 8)
    }
}
