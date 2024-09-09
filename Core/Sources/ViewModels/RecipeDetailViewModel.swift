//
//  RecipeDetailViewModel.swift
//
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import Foundation

@MainActor
open class RecipeDetailViewModel: ObservableObject {
    @Published public private(set) var recipe: Recipe
    @Published public private(set) var isLoading: Bool = false
    private let recipeService = RecipeService()

    public init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    public func fetchRecipeDetails() async {
        isLoading = true
        do {
            let fetchedRecipe = try await recipeService.getRecipeDetails(id: self.recipe.id)
            recipe = fetchedRecipe
            isLoading = false
        } catch {
            print("Failed to fetch recipe details: \(error)")
            isLoading = false
        }
    }
}

