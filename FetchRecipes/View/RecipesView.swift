//
//  ContentView.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//  My Version

import SwiftUI
import UIKit

struct RecipesView: View {
    
    @StateObject var recipesViewModel = RecipesViewModel()
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

#Preview {
    RecipesView()
}
