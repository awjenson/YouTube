//
//  VideoModel.swift
//  YouTube
//
//  Created by Andrew Jenson on 11/5/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit
import Alamofire

class VideoModel: NSObject {

    // Source Video: https://www.youtube.com/watch?v=7xUSH1QLHzk&list=PLMRqhzcHGw1aLoz4pM_Mg2TewmJcMg9ua&index=11

    fileprivate let baseYouTubePlaylistItemsURL = "https://www.googleapis.com/youtube/v3/playlistItems"

    fileprivate let apiKey = "AIzaSyAsMvQe8iVn0LOdPWx-1yUqBwjnar1FvUA"

    fileprivate let uploadsPlaylistId = "UU2D6eRvCeMtcF5OGHf1-trw"

    func getFeedVideos() {

        // Fetch the videos dynamically through YouTube Data API
        Alamofire.request(baseYouTubePlaylistItemsURL, method: .get, parameters: ["part": "snippet", "playlistId": uploadsPlaylistId, "key": apiKey], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in

            print("Result: \(response.result)")                         // response serialization result

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response

                // TODO: Create video objects off of the json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }

        }

    }

}


