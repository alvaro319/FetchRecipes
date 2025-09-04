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
    var networkServiceManager: NetworkDataServiceProtocol = NetworkDataServiceManager()

    @Published var isLoading: Bool = true

    //to reference the singleton to be able to use PhotoModelCacheManager object
    //called 'instance' we create a reference to it
    let cacheManager = PhotoModelCacheManager.instance
    let urlString: String
    //this will hold the id(uuid) defined in RecipesModel.swift class
    let imageKey: String

    init(urlString: String, key: String) {

        self.urlString = urlString
        imageKey = key// the images' id
        print("New ImageLoadingViewModel Created: \(urlString)")
    }
    
    deinit {
        print("DEINITIALIZE NOW: \(urlString)")
    }

    func fetchImage(url: URL) async {
        //get saved image from cache first, if not, download it
        if let savedImage = cacheManager.get(key: imageKey) {
            await MainActor.run {
                isLoading = false
                image = savedImage
                print("Retrieved from cache!")
            }
        }
        else {
            //download it
            await fetchImageAsyncLoader(url: url)
        }
    }

    func fetchImageAsyncLoader(url: URL) async {
        do {
            if let url = URL(string: self.urlString) {
                //let networkServiceManager = NetworkDataServiceManager(url: url)
                let data = try await networkServiceManager.getData(url: url)
                if let image = UIImage(data: data){
                    //await MainActor.run {
                        isLoading = false
                        self.image = image
                        //cache the image
                        self.cacheManager.add(key: self.imageKey, value: image)
                        print("Downloaded image!")
                    //}
                }
                else {
                    //await MainActor.run {
                        defaultImageOnError()
                    //}
                }
            }
            else {
                //await MainActor.run {
                    defaultImageOnError()
                //}
            }
        } catch {
            //await MainActor.run {
                defaultImageOnError()
            //}
        }
    }
    
    public func setDefaultImageOnError() {
        defaultImageOnError()
    }
    
    private func defaultImageOnError() {
        isLoading = false
        self.image = UIImage(systemName: "x.circle.fill")
    }
}
