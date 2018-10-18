//
//  FeedCell.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/17/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

// Represents each one of the sections inside a collection
class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // implement a collectionView inside each feed cell
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self

        return cv
    }()

    var videos: [Video]? // it could be nothing

    let cellId = "cellId"

    func fetchVideos() {
        // added in 'videos:' parameter
        ApiSerivce.sharedInstance.fetchVideos { (videos: [Video]) in

            self.videos = videos
            self.collectionView.reloadData()
        }
    }

    override func setupViews() {
        super.setupViews()

        fetchVideos()

        backgroundColor = .blue

        // add collectionView
        addSubview(collectionView)
        // add constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)

        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }


    // MARK: - CollectionView Functions

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // videos is optional
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell

        // videos is optional
        cell.video = videos?[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 88) // 68 based on Verticle constraints (8,16,44)
    }

    // remove extra spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }


    
}
