//
//  TrendingCell.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/17/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        // added in 'videos:' parameter
        ApiSerivce.sharedInstance.fetchTrendingFeed { (videos: [Video]) in

            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
}
