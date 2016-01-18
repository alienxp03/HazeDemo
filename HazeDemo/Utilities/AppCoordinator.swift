//
//  AppCoordinator.swift
//  HazeDemo
//
//  Created by Muhammad Azuan Zira Zairein on 16/01/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit

class AppCoordinator {
    static let instance = AppCoordinator()

    var navigationController = UINavigationController()
    
    private init() {}
    
    func initViewController() -> UIViewController {
        let viewController = StoryboardScene.Main.locationsViewController()
        viewController.viewModel = LocationsViewModel()
        navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func pushScene(viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popScene() {
        navigationController.popViewControllerAnimated(true)
    }
}
