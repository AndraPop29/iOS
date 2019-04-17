//
//  BaseViewController.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 27/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print(L10n.Andi.name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
