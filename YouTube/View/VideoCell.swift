//
//  VideoCell.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/3/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Layout - Custom Class
class VideoCell: BaseCell {
    // Everytime we call dequeueReusableCell, the code below gets called if it needs a new cell

    var video: Video? {
        didSet {
            titleLabel.text = video?.title

            setupThumbnailImage()
            setupProfileImage()

            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {

                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal

                let subtitleText = "\(channelName) • \(numberFormatter.string(from: NSNumber(value: numberOfViews))!) • 2 years ago "
                subtitleTextView.text = subtitleText
            }

            // measure title text
            if let title = video?.title {

                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)

                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }

            }

        }
    }

    func setupProfileImage() {

        if let profileImageUrl = video?.channel?.profileImageName {

            // See Extensions file for loadImageUsingUrlString
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }

    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {

            // See Extensions file for loadImageUsingUrlString
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }

    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22 // half the width of the entire frame
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()

    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()

    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,604,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()

    var titleLabelHeightConstraint: NSLayoutConstraint?

    override func setupViews() {

        // add superviews for any constraints
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)

        // autolayout for padding for imageView
        // line seperator
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)

        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)

        // Verticle constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, seperatorView)

        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)

        // MARK: Many no longer need
//        addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)


        ///////

        // top constraint - titleLabel
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))


        // left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))

        // right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))

        // height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)

        //////

        // top constraint - subtitleTextView
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))

        // left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))

        // right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))

        // height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))

    }


}

