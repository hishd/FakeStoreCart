//
//  CartViewController.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-20.
//

import UIKit
import Combine

class CartViewController: UIViewController, BaseController {
    
    private let viewModel = CartViewModel()
    private var cartItems: [CartItem] = [] {
        didSet {
            self.cartTableView.reloadData()
        }
    }
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var totalPrice: UILabel = {
        let label = UILabel()
        label.text = "Total Price : $"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Checkout", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(self.handleCheckout), for: .touchUpInside)
        button.setHeight(of: 50)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupObservers()
    }
    

    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Cart"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        cartTableView.dataSource = self
        cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: "CartCell")
        
        //Checkout bottom stack view components
        let checkoutStckView = UIStackView(arrangedSubviews: [totalPrice, checkoutButton])
        checkoutStckView.axis = .vertical
        checkoutStckView.spacing = 10
        checkoutStckView.distribution = .fill
        
        view.addSubview(checkoutStckView)
        checkoutStckView.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: view.safeAreaLayoutGuide.rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        view.addSubview(cartTableView)
        cartTableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: checkoutStckView.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10)
        
        viewModel.getCartItems()
        self.totalPrice.text = String(format: "Total Price : $%.2f", self.viewModel.getCartTotal())
    }
    
    func setupObservers() {
        viewModel.$cartItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.cartItems = items
            }.store(in: &self.cancellables)
    }
    
    @objc func handleCheckout() {
        
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartTableViewCell else {
            fatalError("Unable to create cell")
        }
        
        cell.setData(item: cartItems[indexPath.row])
        cell.callback = { [weak self] item, qty in
            do {
                try self?.viewModel.updateQty(item: item, qty: qty)
                self?.totalPrice.text = String(format: "Total Price : $%.2f", self?.viewModel.getCartTotal() ?? 0.0)
            } catch {
                print(error.localizedDescription)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.4,
            delay: 0.03 * Double(indexPath.row),
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.1,
            options: [.curveEaseInOut],
            animations: {

                cell.alpha = 1
                cell.transform = CGAffineTransform(translationX: 0, y: 0)

        })
    }
    
    //TODO: Implement the remove action of the cart item
}
