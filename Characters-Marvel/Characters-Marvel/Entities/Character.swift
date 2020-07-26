//
//  Character.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 23/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import Foundation

struct Character: Codable {
    var name: String?
    var thumbnail: ThumbNail?
    var description: String?
    var urls: [Urls]
}

struct Urls: Codable {
    let url: URL
}

struct ThumbNail: Codable {
    var path: String?
    var imageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
