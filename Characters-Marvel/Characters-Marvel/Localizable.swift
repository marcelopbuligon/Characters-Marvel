//
//  Enumeration.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 24/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

enum Localizable {
    
    enum welcomePage: String {
        case title = "Marvel"
        case footer = "More Info"
        case searchBar = "Search for a character"
    }
    enum inAppError: String {
        case title = "Error"
        case tryButton = "Try Again"
        case cancelButton = "Cancel"
        case generic = "Oops! An error has occurred"
        case noTitle = "No Title Available"
        case noDescription = "There is no description for this character yet!"
    }
}
