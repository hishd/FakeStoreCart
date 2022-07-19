//
//  HomeViewController.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-19.
//

import Foundation
import UIKit
import Combine

class HomeViewController : UIViewController, BaseViewController {
    
    private lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let viewModel = HomeViewModel(service: FakeStoreAPI.shared)
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        configureUI()
        setupObservers()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Available Items"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
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
            .sink { items in
                
            }.store(in: &self.cancellables)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Unabel to create cell")
        }
        
        return cell
    }
    
    
}
