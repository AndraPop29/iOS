//
//  ListFlowController.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 27/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import UIKit

enum PresentationStyle {
    case push
    case present
}

class ListFlowController {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    var rootViewController: UIViewController {
        let rootViewModel = ListViewModelImpl()
        rootViewModel.flowDelegate = self
        return ListViewController(viewModel: rootViewModel)
    }
    
    func start(presentationStyle: PresentationStyle) {
        switch presentationStyle {
        case .push:
            self.navigationController.pushViewController(rootViewController, animated: true)
        case .present:
            break
        }
    }
}

extension ListFlowController : ListFlowDelegate {
    
    func didSelectItem(on viewModel: ListViewModel) {
        let vc = UIViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}

