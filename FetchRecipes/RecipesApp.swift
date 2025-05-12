//
//  RecipesApp.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 12/4/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            //For testing only
            //if let url = URL(string: "https://alvaro319.github.io/RecipeJSON/RecipeJSON.json") {
            
            //Mal-formed Data:
            //if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json") {
                    
            //Empty Data:
            //if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json") {
                
            if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") {
                let networkServiceManager = NetworkDataServiceManager(url: url)
                RecipesView2(networkManager: networkServiceManager)
            }
            //RecipesView()
        }
    }
}
