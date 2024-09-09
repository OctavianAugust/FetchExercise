//
//  RecipeListViewModel.swift
//
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import Foundation

@MainActor
open class RecipeListViewModel: ObservableObject {
    @Published public private(set) var recipes: [Recipe] = []
    @Published public private(set) var isLoading: Bool = false
    private let recipeService = RecipeService()
    private let category: RecipeCategory
    
    public init(category: RecipeCategory) {
        self.category = category
    }

    public func fetchRecipes() async {
        isLoading = true
        do {
            let fetchedRecipes = try await recipeService.getRecipes(category: self.category)
            recipes = fetchedRecipes
            isLoading = false
        } catch {
            print("Failed to fetch recipes: \(error)")
            isLoading = false
        }
    }
    
    public func sortRecipesAlphabetically() {
        recipes.sort { $0.name < $1.name }
    }
}
