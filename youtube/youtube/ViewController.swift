//
//  ViewController.swift
//  youtube
//
//  Created by Andra Pop on 18/10/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import UIKit
import XCDYouTubeKit
import AVKit


struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.present(playerViewController, animated: true, completion: nil)
//        let vc = VideoViewController()
//        view.addSubview(vc.view)
//        addChildViewController(vc)
//        vc.view.frame = view.frame
        
        XCDYouTubeClient.default().getVideoWithIdentifier("gP9Adjoifg4") { (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                let playerViewController = AVPlayerViewController()
                
                playerViewController.player = AVPlayer(url: streamURL)
                self.view.addSubview(playerViewController.view)
                self.addChildViewController(playerViewController)
                playerViewController.view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 400.0, height: 300.0))
            //    playerViewController.player?.play()
                playerViewController.view.isHidden = true
            }
                
//        vc.playVideo()
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

