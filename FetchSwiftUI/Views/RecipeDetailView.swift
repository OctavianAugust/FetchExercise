//
//  RecipeDetailView.swift
//  SwiftUIProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import SwiftUI
import Kingfisher

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    @State private var isExpandedInstructions: Bool = false
    @State private var isExpandedIngredients: Bool = false

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        if let imageUrl = URL(string: viewModel.recipe.imageUrl) {
                            KFImage(imageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .cornerRadius(10)
                                .padding(.bottom, 8)
                        }
                        Text("Instructions:")
                            .font(.headline)
                        Text(viewModel.recipe.instructions)
                            .lineLimit(isExpandedInstructions ? nil : 2)
                            .padding([.top, .bottom], 0)

                        Button(action: {
                            isExpandedInstructions.toggle()
                        }) {
                            Text(isExpandedInstructions ? "Read Less" : "Read More")
                                .foregroundColor(.gray)
                                .padding([.bottom], 8)
                        }
                        Text("Ingredients:")
                            .font(.headline)
                        Text(viewModel.recipe.ingredientsInString())
                            .lineLimit(isExpandedIngredients ? nil : 2)
                            .padding([.top, .bottom], 0)

                        Button(action: {
                            isExpandedIngredients.toggle()
                        }) {
                            Text(isExpandedIngredients ? "Read Less" : "Read More")
                                .foregroundColor(.gray)
                                .padding([.bottom], 8)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(viewModel.recipe.name)
        .onAppear {
            Task {
                await viewModel.fetchRecipeDetails()
            }
        }
    }
}
