//
//  SoftwareRequest.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 8.10.2022.
//

import Foundation

struct SoftwareRequest: DataRequest {
    
    var searchText: String
    
    var baseURL: String {
        "https://itunes.apple.com"
    }
    
    var url: String {
        "/search"
    }
    
    var queryItems: [String : String] {
        ["term": searchText,
         "media" : "software"]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(searchText: String = "Software") {
        self.searchText = searchText
    }
    
    func decode(_ data: Data) throws -> SoftwareResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(SoftwareResponse.self, from: data)
        return response
    }
}
