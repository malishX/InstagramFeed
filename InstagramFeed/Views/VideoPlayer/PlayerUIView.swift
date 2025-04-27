import AVKit

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    @Binding private var isPlaying: Bool
    
    init(frame: CGRect, videoName: String, isPlaying: Binding<Bool>) {
        self._isPlaying = isPlaying
        super.init(frame: frame)
        
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            print("Video not found")
            return
        }
        
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        
        playerLayer.player = queuePlayer
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    func play() {
        playerLayer.player?.play()
    }
    
    func pause() {
        playerLayer.player?.pause()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    @objc private func appMovedToBackground() {
        pause()
        isPlaying = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
