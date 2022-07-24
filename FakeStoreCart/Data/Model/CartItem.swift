//
//  CartItem.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-23.
//

import Foundation
import TinyCart

struct CartItem: ItemProtocol {
    var name: String
    var price: Double
    var qty: Int
    var image: String
}
