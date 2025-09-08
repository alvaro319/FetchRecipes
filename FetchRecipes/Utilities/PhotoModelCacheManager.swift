//
//  PhotoModelCacheManager.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//

import Foundation
import SwiftUI

actor PhotoModelCacheManager {
    
    //Singleton - only instance of this class in the entire app
    static let instance = PhotoModelCacheManager()
    
    private init() {
    }
    
    //make sure to import SwiftUI above for UIImage
    //computed property
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        //limits the total number of cache objects to store in memory of device
        cache.countLimit = 200
        cache.totalCostLimit = 1024*1024*200// 200MB?
        return cache
    }()
    
    func add(key: String, value: UIImage)
    {
        //call the computed property above called photoCache
        //need to cast String name to NSString
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
    
//    func remove(name: String) -> String {
//        photoCache.removeObject(forKey: name as NSString)
//        return "Removed from cache!"
//    }
}
