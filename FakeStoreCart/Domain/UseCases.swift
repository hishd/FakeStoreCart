//
//  UseCases.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-25.
//

import Foundation

class GetItemDataUseCase {
    let repository: FakeStoreRepository
    init(repository: FakeStoreRepository) {
        self.repository = repository
    }
    
    func execute() -> [Item] {
        return repository.getItemData()
    }
}
