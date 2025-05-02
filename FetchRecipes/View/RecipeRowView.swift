//
//  RecipeRowView.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//

import SwiftUI

//one recipe row
struct RecipeRowView: View {
    
    let recipe: Recipe
    @Binding var isItARefresh: Bool
    
    var body: some View {
        HStack {
            RecipeImageView(url: recipe.photoURLSmall, key: recipe.uuid, itsARefresh: $isItARefresh)
            .frame(width: 80, height: 80)
            VStack(alignment:.leading){
                Text("Cuisine Type: \(recipe.cuisine)")
                Text("Recipe: \(recipe.name)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    RecipeRowView(
        recipe:
            Recipe(
                cuisine: "British",
                name: "Apple & Blackberry Crumble",
                photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                sourceURL: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                uuid: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                youtubeURL: "https://www.youtube.com/watch?v=4vhcOwVBDO4"
            ), isItARefresh: .constant(true))
    .padding()
}
