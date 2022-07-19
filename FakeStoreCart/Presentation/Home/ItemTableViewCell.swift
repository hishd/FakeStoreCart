//
//  ItemTableViewCell.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-20.
//

import Foundation
import UIKit

class ItemTableViewCell : UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(containerView)
        containerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: self.frame.width - 20, height: 140)
    }
    override func layoutSubviews() {
        
    }
}
