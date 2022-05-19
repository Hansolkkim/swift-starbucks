//
//  BeverageInfoDTO.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/18.
//

import Foundation

struct BeverageInfoDTO: Codable {
    let view: View
}

struct View: Codable {
    let productName: String

    enum CodingKeys: String, CodingKey {
        case productName = "product_NM"
    }
}
