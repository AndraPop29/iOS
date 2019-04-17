//
//  RootFlowController.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 27/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import Foundation
import UIKit


class RootFlowController {
    private let window: UIWindow?
    private let rootNavigationController: UINavigationController
    private var listFlowController: ListFlowController!
    
    init(window: UIWindow?) {
        self.window = window
        self.rootNavigationController = UINavigationController()
    }
    
    func start() {
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()

        listFlowController = ListFlowController(navigationController: rootNavigationController)
        listFlowController.start(presentationStyle: .push)

    }
}
