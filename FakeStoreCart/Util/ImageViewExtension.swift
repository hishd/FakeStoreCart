//
//  ImageViewExtension.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-20.
//

import Foundation
import UIKit

extension UIImageView {
    func makeCircle(size: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = size / 2
        self.layer.masksToBounds = true
    }
}
