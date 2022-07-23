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
    @Published var isLoading: Bool = true
    private var cancellables = Set<AnyCancellable>()
    let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func getItems() {
        self.isLoading = true
        service.getData(endPoint: EndPoint.getProducts, type: Item.self)
            .sink { completion in
                self.isLoading = false
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
