//
//  SoftwareResponse.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 8.10.2022.
//

import Foundation

struct SoftwareResponse: Decodable{
    let resultCount:Int?
    let results:[Software]?
}
