
import Foundation
import UIKit


class RootFlowController {
    private let window: UIWindow?
    private let rootNavigationController: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        self.rootNavigationController = UINavigationController()
    }
    
    func start() {
        window?.rootViewController = myViewController()
        window?.makeKeyAndVisible()
    }
}

