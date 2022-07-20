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
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "placeholder")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.makeCircle(size: CGFloat(120))
        return view
    }()
    
    private lazy var titleLabel: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 12)
        view.text = "Title"
        view.setHeight(of: 22)
        return view
    }()
    
    private lazy var priceLabel: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 12)
        view.text = "Price"
        view.setHeight(of: 22)
        return view
    }()
    
    private lazy var categoryLabel: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 12)
        view.text = "Category"
        view.setHeight(of: 22)
        return view
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = .systemFont(ofSize: 12)
        view.textContainer.maximumNumberOfLines = 2
        view.text = "Description"
        view.setHeight(of: 50)
        return view
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addSubview(containerView)
        containerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: self.frame.width - 20, height: 140)
        
        containerView.addSubview(itemImageView)
        itemImageView.setDimensions(height: 120, width: 120)
        itemImageView.centerY(inView: containerView, leftAnchor: containerView.leftAnchor, paddingLeft: 5, constant: 0)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel, categoryLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        containerView.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor, left: itemImageView.rightAnchor, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 5)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
    }
    func setData(item: Item) {
        titleLabel.text = item.title
        priceLabel.text = String(format: "%.2f", item.price)
        categoryLabel.text = item.category
        descriptionLabel.text = item.description
    }
}
