//
//  ItemInfoViewModel.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-22.
//

import Foundation
import TinyCart

class ItemInfoViewModel: ObservableObject {
    private let cart = Cart.shared
    var item: Item
    @Published var selectedQty:Int = 1
    @Published var totalPrice: Double = 0.0
    
    init(item: Item) {
        self.item = item
        self.totalPrice = item.price * Double(selectedQty)
    }
    
    func addToCart() throws {
        try cart.addItem(item: CartItem(name: item.title, price: item.price, qty: selectedQty, image: item.image), qty: selectedQty)
    }
    
    func getTotal() {
        self.totalPrice = item.price * Double(self.selectedQty)
    }
}
