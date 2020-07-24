//
//  CharacterModel.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 23/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import Foundation

protocol CharactersServiceDelegate: AnyObject {
    func didFindCharacters(_ response: [Character])
    func didFail(error:Error)
}

struct Character: Decodable {
    var name: String?
    var thumbnail: ThumbNail?
    var description: String?
}

struct ThumbNail: Decodable {
    var path: String?
    var imageExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
