//
//  Recipe.swift
//
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import Foundation

public struct Recipe: Identifiable {
    public let id: String
    public let name: String
    public let instructions: String
    public let ingredients: [Ingredient]
    public let imageUrl: String
    public let category: RecipeCategory?
    public let area: String?
    public let youtubeUrl: String?
    
    public init(id: String, name: String, instructions: String, ingredients: [Ingredient], imageUrl: String, category: RecipeCategory?, area: String?, youtubeUrl: String?) {
        self.id = id
        self.name = name
        self.instructions = instructions
        self.ingredients = ingredients
        self.imageUrl = imageUrl
        self.category = category
        self.area = area
        self.youtubeUrl = youtubeUrl
    }
    
    public func ingredientsInString() -> String {
        let ingredientsArray: [String] = self.ingredients
            .map { ingredient in
                "\(ingredient.name): (\(ingredient.measurement))"
            }
        
        return ingredientsArray.joined(separator: "\n")
    }
}

