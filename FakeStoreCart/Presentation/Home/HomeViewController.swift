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
        tableView.backgroundColor = .gray
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
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
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
    }
    
    func setupObservers() {
        viewModel.$itemsList
            .receive(on: RunLoop.main)
            .sink { items in
                
            }.store(in: &self.cancellables)
    }
}
