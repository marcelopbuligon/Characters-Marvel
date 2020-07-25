//
//  SearchByNameService.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 25/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import Foundation

protocol SearchByNameServiceProtocol: AnyObject {
    var delegate: CharactersServiceDelegate? { get set }
    func fetchCharactersByName(query: String)
}

final class SearchByNameService: SearchByNameServiceProtocol {
    
    struct Response: Decodable {
        var data: DataStruct?
    }
    
    struct DataStruct: Decodable {
        var limit: Int?
        var results: [Character]?
    }
    
    weak var delegate: CharactersServiceDelegate?
    private let apiRequester: APIRequestProtocol
    
    init(apiRequester: APIRequestProtocol = APIRequest()) {
        self.apiRequester = apiRequester
    }
    
    func fetchCharactersByName(query: String) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = AppURL.base
        components.path = AppURL.charactersPath
        components.queryItems = [
            URLQueryItem(name: "nameStartsWith", value: query),
            URLQueryItem(name: "apikey", value: AppKeys.publicKey),
            URLQueryItem(name: "hash", value: AppKeys.hash),
            URLQueryItem(name: "ts", value: AppKeys.timeStamp)
        ]
        
        guard let urlString = components.url?.absoluteString else { return }
        
        apiRequester.request(
            urlString: urlString,
            method: .get,
            parameters: nil,
            success: { [weak self] (response: Response) in
                self?.delegate?.didFindCharacters(response.data?.results ?? [])
        }) { [delegate] (error) in
            delegate?.didFail(error: error)
        }
    }
}
