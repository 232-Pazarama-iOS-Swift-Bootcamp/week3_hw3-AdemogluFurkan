//
//  MusicResponse.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 7.10.2022.
//

import Foundation

struct MusicResponse: Decodable{
    let resultCount:Int?
    let results:[Music]?
}
