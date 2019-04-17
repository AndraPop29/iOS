//
//  VideoViewController.swift
//  youtube
//
//  Created by Andra Pop on 19/10/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import UIKit
import XCDYouTubeKit
import AVKit

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = .red
        XCDYouTubeClient.default().getVideoWithIdentifier("gP9Adjoifg4") { (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                let playerViewController = AVPlayerViewController()
                playerViewController.player = AVPlayer(url: streamURL)
                self.addChildViewController(playerViewController)
                playerViewController.view.frame = self.view.frame
                
            } else {
                //                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
//    func playVideo() {
//        XCDYouTubeClient.default().getVideoWithIdentifier("gP9Adjoifg4") { (video: XCDYouTubeVideo?, error: Error?) in
//            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
//                let playerViewController = AVPlayerViewController()
//                playerViewController.player = AVPlayer(url: streamURL)
//                self.addChildViewController(playerViewController)
//                playerViewController.view.frame = self.view.frame
//
//            } else {
//                //                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
