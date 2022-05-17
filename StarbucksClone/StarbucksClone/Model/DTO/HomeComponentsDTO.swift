//
//  HomeComponentsDTO.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

struct HomeComponentsDTO: Codable {
    let displayName: String
    let yourRecommand: Recommand
    let mainEvent: MainEvent
    let nowRecommand: Recommand

    enum CodingKeys: String, CodingKey {
        case displayName = "display-name"
        case yourRecommand = "your-recommand"
        case mainEvent = "main-event"
        case nowRecommand = "now-recommand"
    }
}

struct MainEvent: Codable {
    let imageUploadPath: String
    let mobThumbNailImagePath: String

    enum CodingKeys: String, CodingKey {
        case imageUploadPath = "img_UPLOAD_PATH"
        case mobThumbNailImagePath = "mob_THUM"
    }
}

struct Recommand: Codable {
    let products: [String]
}
