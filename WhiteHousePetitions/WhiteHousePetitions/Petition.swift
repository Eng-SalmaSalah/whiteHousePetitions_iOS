//
//  Petition.swift
//  WhiteHousePetitions
//
//  Created by Salma Salah on 2/19/20.
//  Copyright © 2020 Salma Salah. All rights reserved.
//

import Foundation
struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
//make sure you named all the properties in the Petition struct correctly – the Codable protocol matches those names against the JSON directly, so if you have a typo in “signatureCount” then it will fail.

//we can make our struct conforms to codable , if each member in it condorms codable
