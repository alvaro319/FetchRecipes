//
//  RecipesModel.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.

import Foundation

// MARK: - RecipesModel
struct RecipesModel: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
//if a let id: Int is included in the model struct, then the struct must conform to the Identifiable protocol
//Here, uuid is the identifier that distinguishes one recipe from another, include the id:\.uuid when looping through the list of recipes as the distinguishing id: List (recipesViewModel2.recipes, id:\.uuid)
struct Recipe: Codable {
    let cuisine, name: String
    let photoURLLarge, photoURLSmall: String
    let sourceURL: String?
    let uuid: String
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid
        case youtubeURL = "youtube_url"
    }
}
