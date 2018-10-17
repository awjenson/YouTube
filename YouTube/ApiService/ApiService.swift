//
//  ApiService.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/16/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

class ApiSerivce: NSObject {

    static let sharedInstance = ApiSerivce()

    func fetchVideos(completion: @escaping ([Video]) -> ()) {

        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            if error != nil {
                print(error)
                return
            }

            // if success

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)

                // Construct Video objects from json file
                var videos = [Video]()

                for dictionary in json as! [[String: AnyObject]] {

                    print(dictionary["title"])

                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String

                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]

                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String

                    video.channel = channel

                    videos.append(video)

                }

                // main thread for UI
                DispatchQueue.main.async(execute: {
                    completion(videos)
                })


            } catch let jsonError {
                print(jsonError)
            }

            }.resume()

    }


}
