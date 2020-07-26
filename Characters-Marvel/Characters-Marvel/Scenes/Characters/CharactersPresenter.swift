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
    var isFetching: Bool = false
    var isFiltering: Bool = false
    
    private var offset: Int = 0
    private var service: CharactersServiceProtocol
    private var serchByNameService: SearchByNameServiceProtocol
    private var router: CharactersRouterProtocol
    
    init(
        service: CharactersServiceProtocol = CharactersService(),
        serchByNameService:SearchByNameServiceProtocol = SearchByNameService(),
        router: CharactersRouterProtocol
    ) {
        self.service = service
        self.serchByNameService = serchByNameService
        self.router = router
        super.init()
        
        self.service.delegate = self
        self.serchByNameService.delegate = self
    }
    
    func attachView(_ view: CharactersPresenterDelegate) {
        self.view = view
        view.setNavigationTitle(Localizable.welcomePage.title.rawValue)
        fetchCharacters()
    }
    
    func tryAgainButtonDidTap() {
        clearTableView()
        fetchCharacters()
    }
    
    func inputTextDidChange(_ text: String) {
        let characterCount = text.count
        if characterCount  > 1 {
            offset = 0 
            isFiltering = true
            let inputText = text
            serchByNameService.fetchCharactersByName(query: inputText)
            view?.showLoading()
        } else if characterCount == 0 {
            dataSource.removeAll()
            view?.reloadData()
            isFiltering = false
        } else {
            clearTableView()
        }
    }
    
    func rowDidTap(_ row: Int) {
        let model = dataSource[row]
        router.navigateToDetailsScene(model: model)
    }
    
    func userDidRequestedMoreCharacters() {
        fetchCharacters()
    }
    
    private func clearTableView() {
        dataSource.removeAll()
        view?.reloadData()
    }
    
    private func fetchCharacters() {
        service.fetchCharacters(offset: "\(offset)")
        view?.showLoading()
        isFetching = true
    }
}

extension CharactersPresenter: CharactersServiceDelegate {
    func didFindCharacters(_ response: [Character]) {
        
        if !isFiltering {
            offset += 10
        response.forEach { dataSource.append($0) }
        } else {
            dataSource = response
        }
        
        isFetching = false
        view?.hideLoading()
        view?.reloadData()
    }
    
    func didFail(error: Error) {
        view?.hideLoading()
        isFetching = false
        view?.showAlert(
            message: Localizable.inAppError.generic.rawValue,
            buttonTitle: Localizable.inAppError.tryButton.rawValue,
            title: Localizable.inAppError.title.rawValue
        )
    }
}
