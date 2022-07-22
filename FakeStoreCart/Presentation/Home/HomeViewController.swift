//
//  HomeViewController.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-19.
//

import Foundation
import UIKit
import Combine

class HomeViewController : UIViewController, BaseController {
    
    private var itemsList: [Item] = [] {
        didSet {
            itemsTableView.reloadData()
        }
    }
    
    private lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var cartButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(onCartTapped))
        return button
    }()
    
    let viewModel = HomeViewModel(service: FakeStoreAPI.shared)
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        configureUI()
        setupObservers()
        viewModel.getItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Available Items"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        navigationItem.rightBarButtonItem = cartButton
        
        if let navigation = self.navigationController as? CustomNavigationController {
            navigation.requiredStatusBarStyle = .darkContent
        }
        
        view.addSubview(itemsTableView)
        itemsTableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10)
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        itemsTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }
    
    func setupObservers() {
        viewModel.$itemsList
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                self?.itemsList = items
            }.store(in: &self.cancellables)
    }
    
    @objc func onCartTapped() {
        self.navigationController?.pushViewController(CartViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Unabel to create cell")
        }
        cell.setData(item: itemsList[indexPath.row])
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
}
