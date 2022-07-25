//
//  FakeStoreRepository.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-25.
//

import Foundation

protocol FakeStoreRepository {
    func getItemData(callback: @escaping (Result<[Item], Error>) -> Void)
}
