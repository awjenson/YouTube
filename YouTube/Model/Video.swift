//
//  Video.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/5/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

class Video: Decodable {

    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var uploadDate: Date?

    var channel: Channel?

}

class Channel: Decodable {
    var name: String?
    var profileImageName: String?
}
