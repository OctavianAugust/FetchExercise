//
//  APIManager.swift
//  
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import Foundation

public class APIManager {
    func request(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
