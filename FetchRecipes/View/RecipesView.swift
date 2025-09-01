//
//  ContentView.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//  My Version

import SwiftUI
import UIKit

//Original RecipesView No Dependency Injection
/*
struct RecipesView: View {
    
    @StateObject var recipesViewModel = RecipesViewModelNDI()
    @State var isRefresh: Bool = false
        
    var body: some View {
        
        NavigationView {
            List (recipesViewModel.recipes, id:\.uuid) { item in
                RecipeRowView(recipe: item, isItARefresh: $isRefresh)
            }.navigationTitle("Recipes")
            //if user refreshes the screen swiping down
            .refreshable {
//                print("Refresh!")
                isRefresh = true
                
                //Leave this for testing... testing
                //for refresh feature using JSON on github:
                //await recipesViewModel.fetchTest()
                await recipesViewModel.fetch()
            }
        }//end NavigationView
        .task{
//            print(".task")
            isRefresh = false
            await recipesViewModel.fetch()
        }
        .alert(isPresented: $recipesViewModel.show, content: {
            Alert(title: Text(recipesViewModel.titleStr), message: Text(recipesViewModel.messageStr), dismissButton: .default(Text("OK")))
        })
    }
}
 */

struct RecipesView: View {
    
    @StateObject var recipesViewModel: RecipesViewModel
    @State var isRefresh: Bool = false
    
    //Dependency inject the network data service manager
    //TBD, possibly dependency inject a PhotoModelCacheManager object here,
    //similarly to networkManager object in init
    init(networkManager: NetworkDataServiceManager)
    {
        _recipesViewModel = StateObject(wrappedValue: RecipesViewModel(networkMgr: networkManager))
    }
        
    var body: some View {
        
        NavigationView {
            /*
            if a 'let id: Int' is included in the model struct, then the struct must conform to the Identifiable protocol. Here, uuid is the identifier that distinguishes one recipe from another since the RecipesModel struct doesn't have a 'let id: Int'.
             Here we are declaring the uuid property of the struct is the id that will distinguish one recipe from another
            */
            List (recipesViewModel.recipes, id:\.uuid) { item in
                RecipeRowView(recipe: item, isRefresh: $isRefresh)
     
            }.navigationTitle("Recipes")
            //if user refreshes the screen swiping down
            .refreshable {
                //print("Refresh!")
                isRefresh = true
                
                //for refresh feature using JSON on github:
                //await recipesViewModel.fetchTest()//Use for testing
                
                await recipesViewModel.fetch()
            }
            
            //this can also be used to list the recipes, more efficient
            /*
            ScrollView {
                LazyVStack {
                    ForEach(recipesViewModel.recipes, id:\.uuid) { item in
                        RecipeRowView(recipe: item, isItARefresh: $isRefresh)
             
                    }.navigationTitle("Recipes")
                    //if user refreshes the screen swiping down
                    .refreshable {
                        //print("Refresh!")
                        isRefresh = true
                        
                        //Leave this for testing... testing
                        //for refresh feature using JSON on github:
                        //await recipesViewModel.fetchTest()
                        await recipesViewModel.fetch()
                    }
                }
            }
             */
             
        }//end NavigationView
        .task{
            //print(".task")
            isRefresh = false
            await recipesViewModel.fetch()
        }
        .alert(isPresented: $recipesViewModel.show, content: {
            Alert(title: Text(recipesViewModel.titleStr), message: Text(recipesViewModel.messageStr), dismissButton: .default(Text("OK")))
        })
    }
}

#Preview {
    let networkServiceManager = NetworkDataServiceManager()
    RecipesView(networkManager: networkServiceManager)
    
//    if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") {
//        let networkServiceManager = NetworkDataServiceManager(url: url)
//        RecipesView(networkManager: networkServiceManager)
//    }
    //RecipesView()
}
