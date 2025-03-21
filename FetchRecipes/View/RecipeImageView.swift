//
//  RecipeImageView.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//

import SwiftUI

//a single recipe image
struct RecipeImageView: View {
    
    @StateObject var imageLoaderViewModel: ImageLoadingViewModel
    @ObservedObject var viewRefresh: ViewRefresh

    init(url: String, key: String, viewRefresh: ViewRefresh) {
        _imageLoaderViewModel = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
        self.viewRefresh = viewRefresh
    }
    
    var body: some View {
        ZStack {
            if imageLoaderViewModel.isLoading {
                ProgressView()
            } else if let image = imageLoaderViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
        .task {
            
            imageLoaderViewModel.isLoading = true
            //To Do:
            //Need to know in this view if the user did a refresh or not
            //If user did a refresh, then we must fetch the JSON data again for any updates
            //else, call fetchImage() to first determine if the key of the current recipe's image is in the cache, if so, use the cached image.
            if viewRefresh.isRefresh {
 //               print("It's a Refresh, call fetchImageAsyncLoader()")
                await imageLoaderViewModel.fetchImageAsyncLoader()
            } else {
//                print("It's not a Refresh, call fetchImage()")
                await imageLoaderViewModel.fetchImage()
            }
            
        }
    }
}

#Preview {
    RecipeImageView(url: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg", key: "599344f4-3c5c-4cca-b914-2210e3b3312f", viewRefresh: ViewRefresh())
        .frame(width: 80, height: 80)
    
}
