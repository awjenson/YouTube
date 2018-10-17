//
//  ViewController.swift
//  YouTube
//
//  Created by Andrew Jenson on 9/26/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

// To change cell sizes we must conform to UICollectionViewDelegateFlowLayout
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    let cellId = "cellId"
    let titles = ["Home", "Trending", "Subscriptions", "Account"]

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false

        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleLabel

        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }

    func setupCollectionView() {

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }

        collectionView?.backgroundColor = UIColor.white

        // register cell
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)

        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)

        // only display one cell at a time in the view
        collectionView?.isPagingEnabled = true
    }

    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))

        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))

        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }

    @objc func handleSearch() {
        // implement scroll
        scrollToMenuIndex(2)

    }

    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)

        setTitleForIndex(menuIndex)
    }

    private func setTitleForIndex(_ index: Int) {
        // display menu title
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])" // two blank spaces
        }
    }

    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self // references entire controller
        return mb
    }()

    private func setupMenuBar() {

        // Hides navigation title bar on swipe
        navigationController?.hidesBarsOnSwipe = true

        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 320, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)

        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)

        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }


    // Any time you use a lazy var instanciation, the block of code only gets called once if this variable, settingsLauncher, is nil
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()



    @objc func handleMore() {
        // show menu
        // TODO: Use this code for Self-app's Now VC
        settingsLauncher.showSettings()
    }

    func showControllerForSetting(_ setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]


        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }


    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        // Added this formula to follow tutorial which used CGRectMake
        // https://stackoverflow.com/questions/38335046/update-cgrectmake-to-cgrect-in-swift-3-automatically
        return CGRect(x: x, y: y, width: width, height: height)
    }

    // CollectionView is a subclass of UIScrollView
    // This provides the animation of the white bar
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        // divide by 4 because there are four options in menu bar
        menuBar.horizontalBarLeftAnchorContraint?.constant = scrollView.contentOffset.x / 4
    }

    // find the target of the collectionView whenever you scroll
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])

        setTitleForIndex(Int(index))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(view.frame.width, view.frame.height - 50) // 50 comes from the size of the menuBar
    }




}
