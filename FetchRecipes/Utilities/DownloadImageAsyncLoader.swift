//
//  DownloadImageAsyncLoader.swift
//  Recipes
//
//  Created by Alvaro Ordonez on 3/17/25.
//

import Foundation
import SwiftUI

class DownloadImageAsyncLoader {
    
    let url: URL?
    
    init(urlString: String) {
        self.url = URL(string: urlString)
    }
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            //convert data to UIImage obj
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
        
    func downloadWithAsync() async throws -> UIImage?{
        
        do {
            //await keyword is a suspension point on a task,
            //suspend the task until a response is sent back.
            //url session is executed immediately but the response is handled
            //asyncronously
            //self.url is an optional, let's verify it is valid
            guard let url = self.url
            else {
                return nil
            }
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            let image = handleResponse(data: data, response: response)
//            print("image downloaded")
            return image
        } catch {
            throw error
        }
    }
}

