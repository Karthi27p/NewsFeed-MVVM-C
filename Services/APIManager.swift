//
//  APIManager.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 05/02/22.
//

import Foundation
import Combine

enum APIError: Error {
    case serializationError
    case errorResponse
}


struct APIManager {
    static func callApi<T: Decodable>(requestUrl: URLRequest, resultStruct: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: requestUrl).tryMap { result -> T in
            guard let response = result.response as? HTTPURLResponse , response.statusCode == 200  else {
                throw APIError.errorResponse
            }

            let decoder = JSONDecoder()
            do {
                let value = try decoder.decode(T.self, from: result.data)
                return value
            } catch {
                print(error)
                throw APIError.serializationError
            }
            
        }.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}
