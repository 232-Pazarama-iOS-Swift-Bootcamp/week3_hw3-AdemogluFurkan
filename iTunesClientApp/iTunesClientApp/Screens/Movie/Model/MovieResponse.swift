//
//  MovieResponse.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 7.10.2022.
//

import Foundation

struct MovieResponse: Decodable{
    let resultCount:Int?
    let results:[Movie]?
}
