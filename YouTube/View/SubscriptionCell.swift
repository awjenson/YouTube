//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/17/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        // added in 'videos:' parameter
        ApiSerivce.sharedInstance.fetchSubscriptionFeed { (videos: [Video]) in

            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
