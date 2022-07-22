//
//  CartViewModel.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-22.
//

import Foundation
import TinyCart

class CartViewModel: ObservableObject {
    
    private let cart = Cart.shared
    
    func removeItem<T>(item: T) throws where T: ItemProtocol {
        try cart.removeItem(item: item)
    }

    func updateQty<T>(item: T, qty: Int) throws where T: ItemProtocol {
        try cart.updateQuantity(item: item, qty: qty)
    }

    func getCartTotalWithItems() -> (Double, Int) {
        return (cart.getTotalPrice(), 0)
    }
}
