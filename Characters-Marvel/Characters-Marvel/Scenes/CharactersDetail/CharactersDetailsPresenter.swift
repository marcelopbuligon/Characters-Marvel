//
//  CharactersDetailsPresenter.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 25/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import Foundation

protocol CharactersDetailsPresenterDelegate: AnyObject {
    func setupImage(imageUrl: String)
    func setupTitle(title: String)
    func setupDescription(description: String)
    func openURL(_ url: URL)
    func setNavigationTitle(_ text: String)
}

final class CharactersDetailsPresenter {
    private weak var view: CharactersDetailsPresenterDelegate?
    private var model: Character
    
    init(model: Character) {
        self.model = model
    }
    
    func attachView(_ view: CharactersDetailsPresenterDelegate) {
        self.view = view
        setCharacterDescription()
        setCharacterTitle()
        setCharacterImage()
        view.setNavigationTitle("")
    }
    
    private func setCharacterDescription() {
        
        let description = model.description == "" ? Localizable.inAppError.noDescription.rawValue : model.description
        view?.setupDescription(description: description ?? Localizable.inAppError.noDescription.rawValue)
       }
       
    private func setCharacterTitle() {
        let title = model.name == "" ? Localizable.inAppError.noTitle.rawValue : model.name
        view?.setupTitle(title: title ?? Localizable.inAppError.noTitle.rawValue)
    }
    
    private func setCharacterImage() {
        var imgUrl: String = ""
        
        if let path = model.thumbnail?.path, let imgExtension = model.thumbnail?.imageExtension {
           imgUrl = path + "/portrait_uncanny" + "." + imgExtension
        }
        view?.setupImage(imageUrl: imgUrl)
    }
    
    func hyperLinkDidTap() {
        let charactereUrl = model.urls[1]
        view?.openURL(charactereUrl.url)
    }
}
