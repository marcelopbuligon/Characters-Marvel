//
//  CharactersPresenter.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 24/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import Foundation

protocol CharactersPresenterDelegate: AnyObject {
    func showAlert(message: String, buttonTitle: String, title: String)
    func reloadData()
    func showLoading()
    func hideLoading()
    func setNavigationTitle(_ text: String)
}

final class CharactersPresenter: NSObject {
    
    var dataSource: [Character] = []
    
    weak var view: CharactersPresenterDelegate?
    private var service: CharactersServiceProtocol
    private var serchByNameService: SearchByNameServiceProtocol
    
    init(
        service: CharactersServiceProtocol = CharactersService(),
        serchByNameService:SearchByNameServiceProtocol = SearchByNameService()
    ) {
        self.service = service
        self.serchByNameService = serchByNameService
        super.init()
        
        self.service.delegate = self
        self.serchByNameService.delegate = self
    }
    
    func attachView(_ view: CharactersPresenterDelegate) {
        self.view = view
        view.setNavigationTitle(Localizable.welcomePage.title.rawValue)
        service.fetchCharacters()
    }
    
    func inputTextDidChange(_ text: String) {
        let characterCount = text.count
        if characterCount  > 2 {
            let inputText = text
            serchByNameService.fetchCharactersByName(query: inputText)
        } else {
            service.fetchCharacters()
        }
    }
    
    func rowDidTap(_ row: Int) {
        let model = dataSource[row]
    }
}

extension CharactersPresenter: CharactersServiceDelegate {
    func didFindCharacters(_ response: [Character]) {
         dataSource = response
         view?.showLoading()
         view?.reloadData()
    }
    
    func didFail(error: Error) {
        view?.hideLoading()
        view?.showAlert(
            message: Localizable.inAppError.generic.rawValue,
            buttonTitle: Localizable.inAppError.button.rawValue,
            title: Localizable.inAppError.title.rawValue
        )
    }
}
