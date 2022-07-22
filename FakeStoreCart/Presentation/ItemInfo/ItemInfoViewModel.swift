//
//  ItemInfoViewModel.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-22.
//

import Foundation
import TinyCart

class ItemInfoViewModel {
    let cart = Cart.shared
    var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    func addToCart(qty: Int) throws {
        try cart.addItem(item: CartItem(name: item.title, price: item.price), qty: qty)
    }
}
