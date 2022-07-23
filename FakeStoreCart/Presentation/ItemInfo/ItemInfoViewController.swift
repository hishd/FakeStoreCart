//
//  ItemInfoViewController.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-22.
//

import Foundation
import UIKit
import Kingfisher
import Combine

class ItemInfoViewController: UIViewController, BaseController {
    
    let viewModel: ItemInfoViewModel
    var cancellables = Set<AnyCancellable>()
    
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var itemImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3.5
        return view
    }()
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private lazy var itemPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .gray
        return label
    }()
    
    private lazy var itemCategory: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private lazy var itemDescriptionCaption: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Description"
        label.textColor = .black
        return label
    }()
    
    private lazy var itemCategoryContainer: UIView = {
        let view = UIView()
        view.addSubview(itemCategory)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        itemCategory.center(inView: view)
        return view
    }()
    
    private lazy var itemDescription: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 10
        return label
    }()
    
    private lazy var totalPrice: UILabel = {
        let label = UILabel()
        label.text = "Total Price : $"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var addToCart: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Add to Cart", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(self.handleAddtoCart), for: .touchUpInside)
        button.setHeight(of: 40)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var incrementQty: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.handleQtyIncrement), for: .touchUpInside)
        button.setWidth(of: 50)
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "plus.circle.fill")
        config.baseBackgroundColor = .systemGray
        button.configuration = config
        return button
    }()
    
    private lazy var decrementQty: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.handleQtyDecrement), for: .touchUpInside)
        button.setWidth(of: 50)
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "minus.circle.fill")
        config.baseBackgroundColor = .systemGray
        button.configuration = config
        return button
    }()
    
    private lazy var selectedQty: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.setWidth(of: 30)
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "\(viewModel.selectedQty)"
        return label
    }()
    
    private lazy var qtyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        
        let qtyCaption = UILabel()
        qtyCaption.textColor = .systemGray
        qtyCaption.font = .systemFont(ofSize: 15)
        qtyCaption.text = "Select Quantity"
        stackView.addArrangedSubview(qtyCaption)
        
        let stackViewQtySelect = UIStackView(arrangedSubviews: [decrementQty, selectedQty, incrementQty])
        stackViewQtySelect.axis = .horizontal
        stackViewQtySelect.spacing = 10
        stackViewQtySelect.setHeight(of: 40)
        
        stackView.addArrangedSubview(stackViewQtySelect)
        stackView.alignment = .center
        
        return stackView
    }()
    
    init(viewModel: ItemInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupObservers()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        //Setting Item related information
        itemImage.kf.setImage(with: URL(string: viewModel.item.image), placeholder: UIImage(systemName: "airtag"))
        itemCategory.text = viewModel.item.category
        itemTitle.text = viewModel.item.title
        itemPrice.text = String(format: "Price: $%.2f", viewModel.item.price)
        itemDescription.text = viewModel.item.description
    
        //Item Image Component related functions
        view.addSubview(itemImageContainer)
        itemImageContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  left: view.safeAreaLayoutGuide.leftAnchor,
                                  right: view.safeAreaLayoutGuide.rightAnchor,
                                  paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: view.frame.height / 4)
        itemImageContainer.addSubview(itemImage)
        itemImage.anchor(top: itemImageContainer.topAnchor,
                         left: itemImageContainer.leftAnchor,
                         bottom: itemImageContainer.bottomAnchor,
                         right: itemImageContainer.rightAnchor,
                         paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        //Item Price and Item Category related components
        let priceStackView = UIStackView(arrangedSubviews: [itemPrice, itemCategoryContainer])
        priceStackView.axis = .horizontal
        priceStackView.alignment = .bottom
        priceStackView.spacing = 20
        
        //Item Title and Price with Category related components
        let stackView = UIStackView(arrangedSubviews: [itemTitle, priceStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: itemImageContainer.bottomAnchor, left: itemImageContainer.leftAnchor, right: itemImageContainer.rightAnchor, paddingTop: 20)
        stackView.alignment = .leading
        
        itemCategory.layoutIfNeeded()
        itemCategoryContainer.setDimensions(height: itemCategory.frame.height + 15, width: itemCategory.frame.width + 20)
        
        //Item description related components
        let descriptionStackView = UIStackView(arrangedSubviews: [itemDescriptionCaption, itemDescription])
        descriptionStackView.axis = .vertical
        descriptionStackView.alignment = .leading
        descriptionStackView.spacing = 15
        
        view.addSubview(descriptionStackView)
        descriptionStackView.anchor(top: stackView.bottomAnchor, left: itemImageContainer.leftAnchor, right: itemImageContainer.rightAnchor, paddingTop: 20)
        
        //Quantity Bottom stack view related components
        view.addSubview(qtyStackView)
        qtyStackView.anchor(left: itemImageContainer.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            paddingBottom: 10, width: (view.frame.width / 3) + 20)
        
        //Add to cart bottom stack view components
        let addtoCartStackView = UIStackView(arrangedSubviews: [totalPrice, addToCart])
        addtoCartStackView.axis = .vertical
        addtoCartStackView.spacing = 10
        addtoCartStackView.distribution = .fill
        
        view.addSubview(addtoCartStackView)
        addtoCartStackView.anchor(left: qtyStackView.rightAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: itemImageContainer.rightAnchor, paddingLeft: 10, paddingBottom: 10)
    }
    
    private func setupObservers() {
        viewModel.$selectedQty
            .receive(on: RunLoop.main)
            .sink { qty in
                self.selectedQty.text = "\(qty)"
            }
            .store(in: &self.cancellables)
        
        viewModel.$totalPrice
            .receive(on: RunLoop.main)
            .sink { total in
                self.totalPrice.text = String(format: "Total Price : $%.2f", total)
            }
            .store(in: &self.cancellables)
    }
    
    @objc private func handleAddtoCart() {
        
    }
    
    @objc private func handleQtyIncrement() {
        if viewModel.selectedQty >= 99 {
            return
        }
        self.viewModel.selectedQty += 1
        self.viewModel.getTotal()
    }
    
    @objc private func handleQtyDecrement() {
        if viewModel.selectedQty <= 1 {
            return
        }
        self.viewModel.selectedQty -= 1
        self.viewModel.getTotal()
    }
}
