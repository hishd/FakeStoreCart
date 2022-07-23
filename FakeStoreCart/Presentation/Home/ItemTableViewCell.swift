//
//  ItemTableViewCell.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-20.
//

import Foundation
import UIKit
import Kingfisher

class ItemTableViewCell : UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719484448, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3.5
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "placeholder")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.makeCircle(size: CGFloat(120))
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 12)
        view.text = "Title"
        view.setHeight(of: 22)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 12)
        view.text = "Price"
        view.setHeight(of: 22)
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 12)
        view.text = "Category"
        view.setHeight(of: 22)
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .systemFont(ofSize: 12)
        view.numberOfLines = 2
        view.text = "Description"
        view.setHeight(of: 50)
        return view
    }()
    
    private lazy var onTapGesture: UIGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(onTapItem))
    }()
    
    private var item: Item?
    var callback: ((Item) -> Void)?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addSubview(containerView)
        containerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 5, paddingRight: 8, width: self.frame.width - 20, height: 140)
        
        containerView.addSubview(itemImageView)
        itemImageView.setDimensions(height: 120, width: 120)
        itemImageView.centerY(inView: containerView, leftAnchor: containerView.leftAnchor, paddingLeft: 5, constant: 0)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel, categoryLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        containerView.addSubview(stackView)
        containerView.addGestureRecognizer(onTapGesture)
        stackView.anchor(top: containerView.topAnchor, left: itemImageView.rightAnchor, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func setData(item: Item) {
        self.item = item
        titleLabel.text = item.title
        priceLabel.text = String(format: "%.2f", item.price)
        categoryLabel.text = item.category
        descriptionLabel.text = item.description
        itemImageView.kf.setImage(with: URL(string: item.image), placeholder: UIImage(systemName: "airtag"))
    }

    @objc func onTapItem() {
        if let item = item, let callback = callback {
            callback(item)
        }
    }
}
