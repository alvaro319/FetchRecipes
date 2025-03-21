//
//  ContentView.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//  My Version

import SwiftUI
import UIKit

class ViewRefresh: ObservableObject {
        
    //@Published says any time a change is made to this var, let SwiftUI know
    @Published var isRefresh = false
}

struct RecipesView: View {
    
    @StateObject var recipesViewModel = RecipesViewModel()
    @ObservedObject var viewRefresh = ViewRefresh()
        
    var body: some View {
        
        NavigationView {
            List (recipesViewModel.recipes, id:\.uuid) { item in
                RecipeRowView(recipe: item, viewRefresh: viewRefresh)
            }.navigationTitle("Recipes")
            //if user refreshes the screen swiping down
            .refreshable {
//                print("Refresh!")
                viewRefresh.isRefresh = true
                //Leave this for testing:
                //await recipesViewModel.fetchTest()
                
                await recipesViewModel.fetch()
            }
        }//end NavigationView
        .task{
//            print(".task")
            viewRefresh.isRefresh = false
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
