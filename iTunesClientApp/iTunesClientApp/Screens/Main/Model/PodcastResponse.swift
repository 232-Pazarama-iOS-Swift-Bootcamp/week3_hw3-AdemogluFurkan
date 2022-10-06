//
//  PodcastResponse.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 5.10.2022.
//

import Foundation

struct PodcastResponse: Decodable{
    let resultCount:Int?
    let results: [Podcast]?
}
