//
//  ImageLoadingViewModel.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//

import Foundation
import SwiftUI
import Combine
@MainActor

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage?
    let loader: DownloadImageAsyncLoader
    
    @Published var isLoading: Bool = true
        
    //to reference the singleton to be able to use PhotoModelCacheManager object called 'instance' we create a reference to it
    let cacheManager = PhotoModelCacheManager.instance
    let urlString: String
    //this will hold the id(uuid) defined in RecipesModel.swift class
    let imageKey: String
    
    init(url: String, key: String) {
        
        self.urlString = url
        imageKey = key// the images' id
        
        loader = DownloadImageAsyncLoader(urlString: urlString)
    }
    
    func fetchImage() async {
        
        //get saved image from cache first, if not, download it
        if let savedImage = cacheManager.get(key: imageKey) {
//            await MainActor.run {
                isLoading = false
                image = savedImage
                print("Retrieved from cache!")
//            }
        }
        else {
            //download it
            await fetchImageAsyncLoader()
        }
    }
    
    func fetchImageAsyncLoader() async {
        
        do {
            if let image = try await loader.downloadWithAsync() {
                //And because we are in an async environment, you must do the following on the Main thread via a MainActor
//                await MainActor.run {
                    isLoading = false
                    self.image = image
                //cache the image
                    self.cacheManager.add(key: self.imageKey, value: image)
                print("Downloaded image!")
//                }
            }
            else {
//                await MainActor.run {
                    isLoading = false
                    self.image = UIImage(systemName: "x.circle.fill")
//                }
            }
        } catch {
            isLoading = false
            //default to this UIImage if there is an error
            self.image = UIImage(systemName: "x.circle.fill")
        }
        
    }
        
}
