//
//  APIService.swift
//  FakeStoreCart
//
//  Created by Hishara Dilshan on 2022-07-19.
//

import Foundation
import Combine

protocol APIService {
    func getData<T: Decodable>(endPoint: EndPoint, type: T.Type) -> Future<[T], Error>
}
