//
//  APIService.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 15/03/22.
//

import Foundation

@available(iOS 15.0, *)
struct APIService {
    static func callApi<T>(url: URL, resultStruct: T.Type) async -> Result<T, Error> where T: Decodable {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let deocdedResponse = try JSONDecoder().decode(T.self, from: data)
            return Result.success(deocdedResponse)
        }
        catch {
            print(error)
            return Result.failure(error)
        }
    }
}
