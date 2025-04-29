//
//  MainTabBarController.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 05/05/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    lazy var taskListViewController: UINavigationController = {
        let title = "Taks"
        let image = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        let tabItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )

        let rootViewController = TaskListViewController()
        rootViewController.tabBarItem = tabItem

        return UINavigationController(rootViewController: rootViewController)
    }()

    lazy var profileViewController: UIViewController = {
        let title = "Profile"
        let image = UIImage(systemName: "person.fill")
        let tabItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )

        let rootViewController = ProfileViewController()
        rootViewController.tabBarItem = tabItem

        return UINavigationController(rootViewController: rootViewController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [taskListViewController, profileViewController]
    }
}
