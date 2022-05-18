//
//  BeverageImageDTO.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/18.
//

import Foundation

struct BeverageImageDTO: Codable {
    let file: [File]
}

// MARK: - File
struct File: Codable {
    let filePath: String
    let imgUploadPath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_PATH"
        case imgUploadPath = "img_UPLOAD_PATH"
    }
}
