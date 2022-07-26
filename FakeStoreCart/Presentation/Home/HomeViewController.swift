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
    
    let viewModel = DIContainer.shared.container.resolve(HomeViewModel.self)
    var cancellables = Set<AnyCancellable>()
    
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
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return indicator
    }()
    
    private lazy var loadingIndicatorCaption: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = "Loading"
        label.setWidth(of: 100)
        return label
    }()
    
    private lazy var loadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(loadingIndicator)
        stackView.addArrangedSubview(loadingIndicatorCaption)
        return stackView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefreshItems), for: .valueChanged)
        refreshControl.tintColor = .systemBlue
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Items...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        configureUI()
        setupObservers()
        loadingIndicator.isHidden = false
        viewModel?.getItems()
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
            paddingTop: 0,
            paddingLeft: 10,
            paddingBottom: 0,
            paddingRight: 10)
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        itemsTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemCell")
        itemsTableView.addSubview(refreshControl)
        
        view.addSubview(loadingStackView)
        loadingStackView.center(inView: self.view)
    }
    
    func setupObservers() {
        viewModel?.$itemsList
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                self?.refreshControl.endRefreshing()
                self?.itemsList = items
            }.store(in: &self.cancellables)
        
        viewModel?.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loadingStackView.isHidden = false
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingStackView.isHidden = true
                    self?.loadingIndicator.stopAnimating()
                }
            }
            .store(in: &self.cancellables)
    }
    
    @objc func onCartTapped() {
        self.navigationController?.pushViewController(CartViewController(), animated: true)
    }
    
    @objc func onRefreshItems() {
        viewModel?.getItems()
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
        cell.callback = { item in
            self.navigationController?.pushViewController(ItemInfoViewController(viewModel: ItemInfoViewModel(item: item)), animated: true)
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
}
