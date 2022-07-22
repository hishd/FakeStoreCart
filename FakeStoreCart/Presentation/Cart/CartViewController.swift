//
//  CartViewController.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-20.
//

import UIKit

class CartViewController: UIViewController, BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Cart"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

}
