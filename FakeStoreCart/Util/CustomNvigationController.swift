//
//  CustomNvigationController.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-20.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var requiredStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            requiredStatusBarStyle
    }
}
