//
//  CharactersDetailsRouter.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 25/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import UIKit

final class CharactersDetailsRouter: Routerable {
    private var navigation: UINavigationController
    private var model: Character

    
    init(navigation: UINavigationController, model: Character) {
        self.navigation = navigation
        self.model = model
    }

    func makeViewController() -> UIViewController {
        let presenter = CharactersDetailsPresenter(model: model)
        let viewController = CharactersDetailsViewController(presenter: presenter)
        return viewController
    }
}
