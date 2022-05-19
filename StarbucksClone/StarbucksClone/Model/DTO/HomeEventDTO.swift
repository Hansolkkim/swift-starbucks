//
//  HomeEventDTO.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/18.
//

import Foundation

struct HomeEventDTO: Codable {
    let list: [List]
}

struct List: Codable {
    let imageUploadPath: String
    let title, thumbnailImage: String

    enum CodingKeys: String, CodingKey {
        case imageUploadPath = "img_UPLOAD_PATH"
        case title
        case thumbnailImage = "mob_THUM"
    }
}
