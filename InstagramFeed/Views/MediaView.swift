import SwiftUI

struct MediaView: View {
    let media: Media
    let image: UIImage?
    @Binding var isVideoPlaying: Bool
    
    var body: some View {
        ZStack {
            switch media.type {
            case .image:
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(height: UIScreen.main.bounds.width * (media.height / media.width))
                } else {
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width * (media.height / media.width))
                }
            case .video:
                VideoPlayerView(videoName: media.url, isPlaying: $isVideoPlaying)
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.width * (media.height / media.width))
                    .onAppear { isVideoPlaying = true }
                    .onDisappear { isVideoPlaying = false }
            }
        }
    }
}
