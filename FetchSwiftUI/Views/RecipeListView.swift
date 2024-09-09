//
//  RecipeListView.swift
//  SwiftUIProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel(category: .dessert)
    @State private var hasLoaded = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(
                            destination: RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe))
                        ) {
                            RecipeRowView(recipe: recipe)
                        }
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                if !hasLoaded {
                    hasLoaded = true
                    Task {
                        await viewModel.fetchRecipes()
                        viewModel.sortRecipesAlphabetically()
                    }
                }
            }
        }
    }
}
