//
//  VideoLauncher.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/18/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit
import AVFoundation

// may move this class to it's own file/group later
class VideoPlayerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black

        // use your own video file, the bandwidth for google firebase will run out as more and more people use this file
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)

            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame

            player.play()
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }

}

class VideoLauncher: NSObject {

    func showVideoPlayer() {
        print("Play video")

        // container that hold everything in the app
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white

            // animation from bottom right to entire frame
            // 1/2. begining frame
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)

            // 16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16 // inverse of 16:9
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                // 2/2. ending frame
                view.frame = keyWindow.frame

            }) { (completedAnimation) in
                // hide status bar
                UIApplication.shared.isStatusBarHidden = true
            }

            keyWindow.addSubview(view)
        }
    }


}
