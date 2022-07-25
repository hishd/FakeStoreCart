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
    let getItemDataUseCase: GetItemDataUseCase
    
    init(getItemDataUseCase: GetItemDataUseCase) {
        self.getItemDataUseCase = getItemDataUseCase
    }
    
    func getItems() {
        self.isLoading = true
        
        getItemDataUseCase.execute { [weak self] result in
            self?.isLoading = false
            switch(result) {
            case .success(let items) :
                self?.itemsList = items
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }

    }
}
