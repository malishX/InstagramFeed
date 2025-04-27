import SwiftUI

struct VideoPlayerView: UIViewRepresentable {
    let videoName: String
    @Binding var isPlaying: Bool
    
    func makeUIView(context: Context) -> PlayerUIView {
        PlayerUIView(frame: .zero, videoName: videoName)
    }
    
    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        isPlaying ? uiView.play() : uiView.pause()
    }
}
