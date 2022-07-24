//
//  CartViewModel.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-22.
//

import Foundation
import TinyCart
import Combine

class CartViewModel: ObservableObject {
    
    private let cart = Cart.shared
    @Published var cartItems: [CartItem] = []
    
    func getCartItems() {
        self.cartItems = cart.getItemsWithQuantity(type: CartItem.self).map({ item in
            CartItem.init(name: item.key.name, price: item.key.price, qty: item.value, image: item.key.image)
        })
    }
    
    func removeItem<T>(item: T) throws where T: TinyCartItem {
        try cart.removeItem(item: item)
        getCartItems()
    }

    func updateQty<T>(item: T, qty: Int) throws where T: TinyCartItem {
        try cart.setQuantity(item: item, qty: qty)
    }

    func getCartTotal() -> Double {
        return cart.getTotalPrice()
    }
    
    func getItemCount() -> Int {
        return cart.getItemCount()
    }
}
