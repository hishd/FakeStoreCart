//
//  CartTableViewCell.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-24.
//

import UIKit
import Kingfisher

class CartTableViewCell: UITableViewCell {
    
    private var item: CartItem!
    var callback: ((CartItem, Int) -> Void)?
    
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
        image.contentMode = .scaleAspectFit
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
    
    private lazy var incrementQty: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.handleQtyIncrement), for: .touchUpInside)
        button.setWidth(of: 40)
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "plus.circle.fill")
        config.baseBackgroundColor = .systemGray
        button.configuration = config
        return button
    }()
    
    private lazy var decrementQty: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.handleQtyDecrement), for: .touchUpInside)
        button.setWidth(of: 40)
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "minus.circle.fill")
        config.baseBackgroundColor = .systemGray
        button.configuration = config
        return button
    }()
    
    private lazy var selectedQty: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.setWidth(of: 25)
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "\(item.qty)"
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.addSubview(containerView)
        containerView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                             left: self.safeAreaLayoutGuide.leftAnchor,
                             bottom: self.safeAreaLayoutGuide.bottomAnchor,
                             right: self.safeAreaLayoutGuide.rightAnchor,
                             paddingTop: 5,
                             paddingLeft: 8,
                             paddingBottom: 5,
                             paddingRight: 8, height: 140)
        
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
                         paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 5)
        
        let stackViewQtySelect = UIStackView(arrangedSubviews: [decrementQty, selectedQty, incrementQty])
        stackViewQtySelect.axis = .horizontal
        stackViewQtySelect.spacing = 10
        stackViewQtySelect.setHeight(of: 40)
        containerView.addSubview(stackViewQtySelect)
        stackViewQtySelect.anchor(top: stackView.bottomAnchor, left: stackView.leftAnchor, paddingTop: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    func setData(item: CartItem) {
        self.item = item
        self.itemImage.kf.setImage(with: URL(string: item.image), placeholder: UIImage(systemName: "airtag"))
        self.titleLabel.text = item.name
        self.priceLabel.text = String(format: "Price : $%.2f", item.price)
    }
    
    @objc private func handleQtyIncrement() {
        if item.qty >= 99 {
            return
        }
        DispatchQueue.main.async {
            self.item.qty += 1
            self.selectedQty.text = "\(self.item.qty)"
        }
        
        self.publishCallback(item: self.item, qty: self.item.qty)
    }
    
    @objc private func handleQtyDecrement() {
        if item.qty <= 1 {
            return
        }
        DispatchQueue.main.async {
            self.item.qty -= 1
            self.selectedQty.text = "\(self.item.qty)"
        }
        self.publishCallback(item: self.item, qty: self.item.qty)
    }
    
    private func publishCallback(item: CartItem, qty: Int) {
        if let callback = callback {
            callback(item, qty)
        }
    }
}
