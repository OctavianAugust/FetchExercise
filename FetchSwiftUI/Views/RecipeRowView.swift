//
//  RecipeRowView.swift
//  SwiftUIProject
//
//  Created by Roman Myroniuk on 07.09.2024.
//
import SwiftUI
import Kingfisher

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            if let url = URL(string: recipe.imageUrl) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            }
            Text(recipe.name)
                .font(.headline)
        }
    }
}
