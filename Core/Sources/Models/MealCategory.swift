//
//  File.swift
//  
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import Foundation

public struct MealCategoryResponse: Codable {
    public let meals: [MealCategory]
}

public struct MealCategory: Codable {
    public let strMeal: String?
    public let strMealThumb: String?
    public let idMeal: String?
}
