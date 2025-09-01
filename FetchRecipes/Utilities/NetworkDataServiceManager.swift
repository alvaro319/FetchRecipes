//
//  NetworkDataServiceManager.swift
//  FetchRecipes
//
//  Created by Alvaro Ordonez on 5/6/25.
//

import Foundation
import SwiftUI

protocol NetworkDataServiceProtocol {
    func getData(url: URL) async throws -> Data
}

class NetworkDataServiceManager: NetworkDataServiceProtocol  {
    
//    let url: URL
//    
//    init(url: URL) {
//        self.url = url
//    }
    
    func getData(url: URL) async throws -> Data {
        //use a URLSession object(this does the networking part) to create a task using the URL object
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard
            let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
