//
//  CharactersRouter.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 24/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import UIKit

protocol Routerable {
    func makeViewController() -> UIViewController
}

final class CharactersRouter: Routerable {
    private var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func makeViewController() -> UIViewController {
        let presenter = CharactersPresenter()
        let viewController = CharactersViewController(presenter: presenter)
        return viewController
    }
}
