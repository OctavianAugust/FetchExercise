//
//  RecipeService.swift
//
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import Foundation

public class RecipeService {
    private let apiManager = APIManager()
    private let urlBuilder = URLBuilder()

    func getRecipes(category: RecipeCategory) async throws -> [Recipe] {
        guard let url = urlBuilder.buildURL(for: .filterByCategory(category.rawValue)) else {
            throw URLError(.badURL)
        }

        let data = try await apiManager.request(url: url)
        
        let mealResponse = try JSONDecoder().decode(MealCategoryResponse.self, from: data)

        let validMeals = mealResponse.meals.compactMap { meal -> Recipe? in
            guard
                let idMeal = meal.idMeal, !idMeal.isEmpty,
                let name = meal.strMeal, !name.isEmpty,
                let imageUrl = meal.strMealThumb, !imageUrl.isEmpty else {
                return nil
            }

            return Recipe(
                id: idMeal,
                name: name,
                instructions: "",
                ingredients: [],
                imageUrl: imageUrl,
                category: nil,
                area: nil,
                youtubeUrl: nil
            )
        }
        
        return validMeals
    }

    func getRecipeDetails(id: String) async throws -> Recipe {
        guard let url = urlBuilder.buildURL(for: .lookupById(id)) else {
            throw URLError(.badURL)
        }

        let data = try await apiManager.request(url: url)
        
        let mealResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)

        guard let meal = mealResponse.meals.first,
              let idMeal = meal.idMeal, !idMeal.isEmpty,
              let name = meal.strMeal, !name.isEmpty,
              let instructions = meal.strInstructions, !instructions.isEmpty,
              let imageUrl = meal.strMealThumb, !imageUrl.isEmpty else {
            throw URLError(.badServerResponse)
        }

        return Recipe(
            id: idMeal,
            name: name,
            instructions: instructions,
            ingredients: extractIngredientsAndMeasurements(from: meal),
            imageUrl: imageUrl,
            category: RecipeCategory(rawValue: meal.strCategory ?? ""),
            area: meal.strArea,
            youtubeUrl: meal.strYoutube
        )
    }

    private func extractIngredientsAndMeasurements(from meal: Meal) -> [Ingredient] {
        var ingredients: [Ingredient] = []

        let ingredientNames = [
            meal.strIngredient1, meal.strIngredient2, meal.strIngredient3,
            meal.strIngredient4, meal.strIngredient5, meal.strIngredient6,
            meal.strIngredient7, meal.strIngredient8, meal.strIngredient9,
            meal.strIngredient10, meal.strIngredient11, meal.strIngredient12,
            meal.strIngredient13, meal.strIngredient14, meal.strIngredient15,
            meal.strIngredient16, meal.strIngredient17, meal.strIngredient18,
            meal.strIngredient19, meal.strIngredient20
        ]

        let measurements = [
            meal.strMeasure1, meal.strMeasure2, meal.strMeasure3,
            meal.strMeasure4, meal.strMeasure5, meal.strMeasure6,
            meal.strMeasure7, meal.strMeasure8, meal.strMeasure9,
            meal.strMeasure10, meal.strMeasure11, meal.strMeasure12,
            meal.strMeasure13, meal.strMeasure14, meal.strMeasure15,
            meal.strMeasure16, meal.strMeasure17, meal.strMeasure18,
            meal.strMeasure19, meal.strMeasure20
        ]

        for (name, measure) in zip(ingredientNames, measurements) {
            if let name = name, !name.isEmpty, let measure = measure, !measure.isEmpty {
                ingredients.append(Ingredient(name: name, measurement: measure))
            }
        }

        return ingredients
    }
}
