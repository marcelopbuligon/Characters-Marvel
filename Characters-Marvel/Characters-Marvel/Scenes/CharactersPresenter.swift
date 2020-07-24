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
    func setTitle(_ text: String)
}

final class CharactersPresenter: NSObject {
    
    var dataSource: [Character] = []
    private weak var view: CharactersPresenterDelegate?
    private var service: CharactersServiceProtocol
    
    init(
        service: CharactersServiceProtocol = CharactersService()
    ) {
        self.service = service
        super.init()
        
        self.service.delegate = self
    }
    
    func attachView(_ view: CharactersPresenterDelegate) {
        self.view = view
        view.setTitle("key do titulo")
        
        service.charactersSearch()
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
            message: "Fazer ENUM de erros",
            buttonTitle: "Tente Novamente",
            title: "Enum de erros")
    }
}
