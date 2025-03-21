//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/24.

import Foundation
//a singleton actor whose executor is equivalent to the main dispatch queue
@MainActor //runs the async function below in a background thread


class RecipesViewModel : ObservableObject {

    @Published var recipes: [Recipe] = []
    @Published var show: Bool = false
    @Published var titleStr = "Alert!"
    @Published var messageStr = "Something went wrong!"
    
    func fetch() async {
        do {
            
            //For testing only
            //guard let url = URL(string: "https://alvaro319.github.io/RecipeJSON/RecipeJSON.json")
            
            //create a URL object
            guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")

            //Mal-formed Data:
            //guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
                    
            //Empty Data:
            //guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")

            else {
                return
            }
            
            //use a URLSession object(this does the networking part) to create a task using the URL
//            let (data, response) = try await URLSession.shared.data(from: url)
            let (data, _) = try await URLSession.shared.data(from: url)

            //RecipesModel is the type of data being returned. It is an array of recipes, therefore, below need to get the RecipesModel object's recipes.
            let jsonDecodedRecipes = try JSONDecoder().decode(RecipesModel.self, from: data)
                
            if(jsonDecodedRecipes.recipes.isEmpty){
                messageStr = "No Data Found"
                show = true
            }
            else {
                //received good data
                show = false
                self.recipes = jsonDecodedRecipes.recipes
                print("recipes: \(recipes)")
                print("Downloaded JSON!")
            }
        } catch let error as NSError{
            show = true
            messageStr = error.localizedDescription
            print("Failed to decode: ", error.localizedDescription)
        }
    }//end fetch()
    
    //For testing purposes only to be used in conjunction with the refresh-pulldown gesture
    //Must replace the call to fetch() with fetchTest() within
    //.refreshable {}
    func fetchTest() async {
        do {
            
            guard let url = URL(string: "https://alvaro319.github.io/RecipeJSON/RecipeJSON.json")
            
            //create a URL object
            //guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")

            //Mal-formed Data:
            //guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
                    
            //Empty Data:
            //guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")

            else {
                return
            }
            
            //use a URLSession object(this does the networking part) to create a task using the URL
//            let (data, response) = try await URLSession.shared.data(from: url)
            let (data, _) = try await URLSession.shared.data(from: url)

            //RecipesModel is the type of data being returned. It is an array of recipes, therefore, below need to get the RecipesModel object's recipes.
            let jsonDecodedRecipes = try JSONDecoder().decode(RecipesModel.self, from: data)
                
            if(jsonDecodedRecipes.recipes.isEmpty){
                messageStr = "No Data Found"
                show = true
            }
            else {
                show = false
                self.recipes = jsonDecodedRecipes.recipes
//                print("Recipes Downloaded!")
//                print(response)
//                print(jsonDecodedRecipes.recipes)
            }
        } catch let error as NSError{
            show = true
            messageStr = error.localizedDescription
            print("Failed to decode: ", error.localizedDescription)
        }
    }//end fetchTest()

}
    
