//
//  ItemInfoViewController.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-22.
//

import Foundation
import UIKit
import Kingfisher

class ItemInfoViewController: UIViewController, BaseController {
    
    let viewModel: ItemInfoViewModel
    
    lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        return image
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
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.item.title
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        view.addSubview(itemImage)
        itemImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: view.frame.height / 3)
        
        itemImage.kf.setImage(with: URL(string: viewModel.item.image), placeholder: UIImage(systemName: "airtag"))
    }
}
