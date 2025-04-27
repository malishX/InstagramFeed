import AVKit
import UIKit

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    var isPlaying: Bool = false  // Remove @Binding
    
    init(frame: CGRect, videoName: String) {  // Remove isPlaying parameter
        super.init(frame: frame)
        setupPlayer(with: videoName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayer(with videoName: String) {
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            print("Video not found")
            return
        }
        
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        
        playerLayer.player = queuePlayer
        layer.addSublayer(playerLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    func play() {
        playerLayer.player?.play()
        isPlaying = true
    }
    
    func pause() {
        playerLayer.player?.pause()
        isPlaying = false
    }
}
