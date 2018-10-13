//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Andrew Jenson on 10/12/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

// create a class that acts as our model object for each of the settings
class Setting: NSObject {
    let name: String
    let imageName: String

    // need to initialize the stored properties
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // global scope because it needs to be used by two functions
    let blackView = UIView()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()

    let cellId = "cellId"
    let cellHeight: CGFloat = 50

    let settings: [Setting] = {
        return [
            Setting(name: "Setting", imageName: "settings"),
            Setting(name: "Terms & Privacy Policy", imageName: "privacy"),
            Setting(name: "Send Feedback", imageName: "feedback"),
            Setting(name: "Help", imageName: "help"),
            Setting(name: "Switch Account", imageName: "switch_account"),
            Setting(name: "Cancel", imageName: "cancel")
        ]
    }()

    func showSettings() {
        // show menu
        // UIApplication.shared.keyWindow is the entire iphone screen
        if let window = UIApplication.shared.keyWindow {

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            // to disapear blackView when user taps screen
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))


            window.addSubview(blackView)
            window.addSubview(collectionView) // add collectionView after blackView

            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let yValue = window.frame.height - height
            // set starting yValue to window.frame.height (will animate)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            blackView.frame = window.frame
            blackView.alpha = 0

            // more professional animation with curveEaseOut
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                self.blackView.alpha = 1

                self.collectionView.frame = CGRect(x: 0, y: yValue, width: self.collectionView.frame.width, height: self.collectionView.frame.height)

            }, completion: nil)

        }
    }

    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0

            // we want to get the y-value to equal the window of the iphone screen
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }

        }
    }

    // conform to UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell

        let setting = settings[indexPath.row]
        cell.setting = setting

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(collectionView.frame.width, cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // reduces the default gap between the cells
        return 0
    }

    override init() {
        super.init()

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }

}
