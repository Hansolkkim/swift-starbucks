//
//  WhatsNewEventDTO.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import Foundation

struct WhatsNewEventDTO: Codable {
    let title: String
    let imageURL: String
    let startAt, endAt: String
}
