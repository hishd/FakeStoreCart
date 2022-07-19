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
    
    let viewModel = HomeViewModel(service: FakeStoreAPI.shared)
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        configureUI()
        setupObservers()
    }
    
    func configureUI() {
        
    }
    
    func setupObservers() {
        viewModel.$itemsList
            .receive(on: RunLoop.main)
            .sink { items in
                
            }.store(in: &self.cancellables)
    }
}
