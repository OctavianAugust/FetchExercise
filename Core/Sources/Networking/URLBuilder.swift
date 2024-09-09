//
//  File.swift
//  
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import Foundation

public class URLBuilder {
    private let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    func buildURL(for endpoint: Endpoint) -> URL? {
        var urlString = baseURL
        
        switch endpoint {
        case .filterByCategory(let category):
            urlString += "filter.php?c=\(category)"
        case .lookupById(let id):
            urlString += "lookup.php?i=\(id)"
        }
        
        return URL(string: urlString)
    }
    
    enum Endpoint {
        case filterByCategory(String)
        case lookupById(String)
    }
}
