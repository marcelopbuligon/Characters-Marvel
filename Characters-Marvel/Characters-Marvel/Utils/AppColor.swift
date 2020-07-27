//
//  AppColor.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 26/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import UIKit

enum AppColor: String {
    case shadow
    
    var color: UIColor { return UIColor(named: rawValue) ?? .black }
    var cgColor: CGColor { return color.cgColor }
}
