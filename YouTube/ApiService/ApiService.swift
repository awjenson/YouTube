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

    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"

    func fetchVideos(completion: @escaping ([Video]) -> ()) {

        fetchFeedForUrlString("\(baseUrl)/home.json", completion: completion)
    }

    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {

        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }

    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {

        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }

    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            if error != nil {
                print(error ?? "")
                return
            }

            do {
                guard let data = data else {return}
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let videos = try decoder.decode([Video].self, from: data)

                DispatchQueue.main.async {
                    completion(videos)
                }

            } catch let jsonError {
                print(jsonError)
            }

            }.resume()


    }



}
