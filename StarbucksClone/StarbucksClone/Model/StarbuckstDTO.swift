//
//  StarbuckstDTO.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/12.
//

import Foundation

struct Welcome: Codable {
    let title, range, target, description: String
    let eventProducts: String

    enum CodingKeys: String, CodingKey {
        case title, range, target, description
        case eventProducts = "event-products"
    }
}
