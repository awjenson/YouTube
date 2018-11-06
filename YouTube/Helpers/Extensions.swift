//
//  Extensions.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/3/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {

        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

// Save user's phone memory with image cache when displaying images
let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {

    var imageUrlString: String?

    func loadImageUsingUrlString(urlString: String) {

        imageUrlString = urlString

        let url = URL(string: urlString)

        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            if error != nil {
                print(error)
                return
            }

            DispatchQueue.main.async(execute: {

                let imageToCache = UIImage(data: data!)

                if self.imageUrlString == urlString {
                    // display image in UI
                    self.image = imageToCache
                }

                // store image in imageCache
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            })
        }.resume()
    }
}


