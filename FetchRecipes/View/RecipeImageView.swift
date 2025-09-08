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
    @Binding var isRefresh: Bool

    /*
     The @StateObject var imageLoaderViewModel needs to
     be initialized within init() to be able to inject
     our dependency in it, namely, the url string and the key
     so the image loader can fetch the image(whether from
     the network or cache)
     */
    init(urlString: String, key: String, isRefresh: Binding<Bool>) {
        _imageLoaderViewModel =
            StateObject(wrappedValue: ImageLoadingViewModel(urlString: urlString, key: key))
        _isRefresh = isRefresh
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
            
            //Need to know in this view if the user did a refresh or not
            //If user did a refresh, then we must fetch the JSON data again for any updates
            if let url = URL(string: imageLoaderViewModel.urlString)
            {
                if isRefresh {
                    print("REFRESH!!!, DOWNLOAD IMAGE!")
                    await imageLoaderViewModel.fetchImageAsyncLoader(url: url)
                }
                else {
                    await imageLoaderViewModel.fetchImage(url: url)
                }
                
            }
            else {
                print("Invalid URL")
                imageLoaderViewModel.setDefaultImageOnError()
            }
        }
    }
}

#Preview {
    RecipeImageView(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg", key: "599344f4-3c5c-4cca-b914-2210e3b3312f", isRefresh: .constant(true))
        .frame(width: 80, height: 80)
    
}
