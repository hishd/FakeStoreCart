//
//  FakeStoreRepositoryComponent.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-25.
//

import Foundation
import Combine

class FakeStoreRepositoryComponent: FakeStoreRepository {
    
    private let service: APIService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: APIService) {
        self.service = service
    }
    
    
    func getItemData(callback: @escaping (Result<[Item], Error>) -> Void) {
        service.getData(endPoint: EndPoint.getProducts, type: Item.self)
            .sink { completion in
                switch(completion) {
                case .failure(let error) :
                    print(error)
                case .finished :
                    print("Success")
                }
            } receiveValue: { items in
                callback(.success(items))
            }
            .store(in: &self.cancellables)
    }
}
