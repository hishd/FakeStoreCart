//
//  DIContainer.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-24.
//

import Foundation
import Swinject

class DIContainer {
    static let shared = DIContainer()
    private init() {}
    
    let container: Container = {
        let container = Container()
        container.register(APIService.self) { _ in
            FakeStoreAPI.shared
        }
        container.register(FakeStoreRepository.self) { resolver in
            FakeStoreRepositoryComponent(service: resolver.resolve(APIService.self)!)
        }
        container.register(GetItemDataUseCase.self) { resolver in
            GetItemDataUseCase(repository: resolver.resolve(FakeStoreRepository.self)!)
        }
        container.register(HomeViewModel.self) { resolver in
            HomeViewModel(getItemDataUseCase: resolver.resolve(GetItemDataUseCase.self)!)
        }
        return container
    }()
}
