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

protocol CharactersRouterProtocol: AnyObject {
    func navigateToDetailsScene(model: Character)
}

final class CharactersRouter: Routerable {
    private var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func makeViewController() -> UIViewController {
        let presenter = CharactersPresenter(router: self)
        let viewController = CharactersViewController(presenter: presenter)
        return viewController
    }
}

extension CharactersRouter: CharactersRouterProtocol {
    func navigateToDetailsScene(model: Character) {
        
        let router = DetailsRouter(navigation: navigation, model: model)
         let vc = router.makeViewController()
        navigation.present(vc, animated: true, completion: nil)
//         navigation.pushViewController(vc, animated: true)
    }
}
