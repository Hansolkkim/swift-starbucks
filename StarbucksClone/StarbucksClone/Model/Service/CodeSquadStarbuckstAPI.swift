//
//  CodeSquadStarbuckstAPI.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/12.
//

import Foundation

enum CodeSquadStarbuckst {
    static let baseURL = "https://public.codesquad.kr/jk/boostcamp"
    
    case starbuckstLoading
    
    var url: URL? {
        switch self {
        case .starbuckstLoading:
            return URL(string: Self.baseURL + "/starbuckst-loading.json")
        }
    }

    var method: String {
        switch self {
        case .starbuckstLoading:
            return "GET"
        }
    }
}
