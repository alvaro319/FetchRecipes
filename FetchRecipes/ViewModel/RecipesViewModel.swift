//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.

import Foundation

//Uses Dependency Injection with NetworkDataServiceManagerProtocol
class RecipesViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var show: Bool = false
    @Published var titleStr = "Alert!"
    @Published var messageStr = "Something went wrong!"
    
    //private var networkManager: NetworkDataService
    private var networkManager: NetworkDataServiceProtocol
    
    //dependency inject the NetworkDataServiceManagerProtocol object into this viewModel
    init(networkMgr: NetworkDataServiceProtocol) {
        self.networkManager = networkMgr
    }
    
    func fetch() async {
        do {
            if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") {
                //fetch the data from the API
                let data = try await networkManager.getData(url: url)
                
                //RecipesModel is the type of data being returned. It is an array of recipes, therefore, below need to get the RecipesModel object's recipes.
                let jsonDecodedRecipes = try JSONDecoder().decode(RecipesModel.self, from: data)
                
                if(jsonDecodedRecipes.recipes.isEmpty){
                    await MainActor.run {
                        messageStr = "No Data Found"
                        show = true
                    }
                }
                else {
                    //received good data
                    await MainActor.run {
                        show = false
                        self.recipes = jsonDecodedRecipes.recipes
                        print("recipes: \(recipes)")
                        print("Downloaded JSON!")
                    }
                }
            }

        }
        catch let error as NSError{
            await MainActor.run {
               show = true
                messageStr = "Malformed Data: " + error.localizedDescription
                print("Failed to decode(malformed data): ", error.localizedDescription)
            }
        }
    }
}

//Original RecipesViewModel - No Dependency Injection(NDI)
/*
class RecipesViewModelNDI : ObservableObject {

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
                await MainActor.run {
                    messageStr = "No Data Found"
                    show = true
                }
            }
            else {
                //received good data
                await MainActor.run {
                    show = false
                    self.recipes = jsonDecodedRecipes.recipes
                    print("recipes: \(recipes)")
                    print("Downloaded JSON!")
                }
            }
        } catch let error as NSError{
            await MainActor.run {
               show = true
                messageStr = error.localizedDescription
                print("Failed to decode: ", error.localizedDescription)
            }
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
               await MainActor.run {
                messageStr = "No Data Found"
                show = true
               }
            }
            else {
               await MainActor.run {
                show = false
                self.recipes = jsonDecodedRecipes.recipes
               }
//                print("Recipes Downloaded!")
//                print(response)
//                print(jsonDecodedRecipes.recipes)
            }
        } catch let error as NSError{
           await MainActor.run {
            show = true
            messageStr = error.localizedDescription
            print("Failed to decode: ", error.localizedDescription)
           }
        }
    }//end fetchTest()

}
*/
