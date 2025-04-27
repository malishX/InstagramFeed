import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    let videoName: String
    @Binding var isPlaying: Bool
    
    func makeUIView(context: Context) -> UIView {
        PlayerUIView(frame: .zero, videoName: videoName, isPlaying: $isPlaying)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let playerUIView = uiView as? PlayerUIView else { return }
        isPlaying ? playerUIView.play() : playerUIView.pause()
    }
}
