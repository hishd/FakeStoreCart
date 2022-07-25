//
//  UseCases.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-25.
//

import Foundation

class GetItemDataUseCase {
    private let repository: FakeStoreRepository
    init(repository: FakeStoreRepository) {
        self.repository = repository
    }
    
    func execute(callback: @escaping (Result<[Item], Error>) -> Void) {
        repository.getItemData(callback: callback)
    }
}
