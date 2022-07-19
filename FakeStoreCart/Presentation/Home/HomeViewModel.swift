//
//  HomeViewModel.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-19.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var itemsList: [Item] = []
    private var cancellables = Set<AnyCancellable>()
    let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func getItems() {
        service.getData(endPoint: EndPoint.getProducts, type: Item.self)
            .sink { completion in
                switch(completion) {
                case .failure(let error) :
                    print(error)
                case .finished :
                    print("Success")
                }
            } receiveValue: { [weak self] items in
                self?.itemsList = items
            }
            .store(in: &self.cancellables)

    }
}
