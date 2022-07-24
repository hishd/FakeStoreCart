//
//  CartItem.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-23.
//

import Foundation
import TinyCart

class CartItem: TinyCartItem {
    var qty: Int
    var image: String
    
    init(name: String, price: Double, qty: Int, image: String) {
        self.qty = qty
        self.image = image
        super.init(name: name, price: price)
    }
}
