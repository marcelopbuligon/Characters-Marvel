//
//  CryptoKeys.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 23/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import CryptoKit
import Foundation

enum AppKeys {
    static let publicKey = ""
    static let privateKey = ""
    static let timeStamp = String(NSDate().timeIntervalSince1970.description)
    
    static var hash: String {
        return (timeStamp + privateKey + publicKey).md5()
    }
}

// MARK: - Crypto Extension
private extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
