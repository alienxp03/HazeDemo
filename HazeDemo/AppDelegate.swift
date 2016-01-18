//
//  AppDelegate.swift
//  HazeDemo
//
//  Created by Muhammad Azuan Zira Zairein on 16/01/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = AppCoordinator.instance.initViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

