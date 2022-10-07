//
//  Movie.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 7.10.2022.
//

import Foundation


struct Movie: Decodable {
    let artistName: String?
    let trackName: String?
    let collectionName:String?
    let artworkLarge: URL?
    let releaseDate: String?
    let country: String?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case artworkLarge = "artworkUrl100"
        case collectionName
        case releaseDate
        case country
        case genres
    }
}
