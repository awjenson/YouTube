//
//  Video.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/5/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

class Video: NSObject {

    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?

    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
