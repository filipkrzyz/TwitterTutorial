//
//  MainTabController.swift
//  TwitterTutorial
//
//  Created by Filip Krzyzanowski on 31/08/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .twitterBlue
        // logOut()
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navigationController = UINavigationController (rootViewController: LoginController())
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        } else {
            configureUI()
            configureViewControllers()
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out: \(error)")
        }
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped() {
        
    }

    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2    // for rounded corners take height and divide by 2
    }
    
    func configureViewControllers() {
        let feed = FeedController()
        let feedNavController = templateNavigationController(image: UIImage(named: "home_unselected"), rootController: feed)
        
        let explore = ExploreController()
        let exploreNavController = templateNavigationController(image: UIImage(named: "search_unselected"), rootController: explore)
        
        let notifications = NotificationsController()
        let notificationsNavController = templateNavigationController(image: UIImage(named: "like_unselected"), rootController: notifications)
        
        let conversations = ConversationsController()
        let convarsationsNavController = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootController: conversations)
        
        viewControllers = [feedNavController, exploreNavController, notificationsNavController, convarsationsNavController]
    }
    
    func templateNavigationController(image: UIImage?, rootController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.tintColor = .white
        return navigationController
    }
    
}