//
//  CartTableViewCell.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-24.
//

import UIKit
import Kingfisher

class CartTableViewCell: UITableViewCell {
    
    private var item: Item!
    var callback: (item: Item, qty: Int)?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3.5
        return view
    }()
    
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.makeCircle(size: CGFloat(120))
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .boldSystemFont(ofSize: 15)
        view.numberOfLines = 2
        view.text = "Title"
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = .boldSystemFont(ofSize: 15)
        view.text = "Price : $"
        return view
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.addSubview(containerView)
        containerView.anchor(top: self.topAnchor,
                             left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             paddingTop: 5,
                             paddingLeft: 8,
                             paddingBottom: 5,
                             paddingRight: 8,
                             width: self.frame.width - 20, height: 140)
        
        containerView.addSubview(itemImage)
        itemImage.setDimensions(height: 120, width: 120)
        itemImage.centerY(inView: containerView, leftAnchor: containerView.leftAnchor, paddingLeft: 5, constant: 0)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        containerView.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor,
                         left: itemImage.rightAnchor,
                         right: containerView.rightAnchor,
                         paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    func setData(item: Item) {
        self.item = item
        self.itemImage.kf.setImage(with: URL(string: item.image), placeholder: UIImage(systemName: "airtag"))
        self.titleLabel.text = item.title
        self.priceLabel.text = String(format: "Price : $%.2f", item.price)
    }
}
