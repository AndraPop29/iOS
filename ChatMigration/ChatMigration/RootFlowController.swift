//
//  RootFlowController.swift
//  ChatMigration
//
//  Created by Andra Pop on 11/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//


import UIKit

class RootFlowController {
    
    var navigationController: UINavigationController
    private let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    var rootViewController: UIViewController {
        return ChatViewController()
    }

    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
}
