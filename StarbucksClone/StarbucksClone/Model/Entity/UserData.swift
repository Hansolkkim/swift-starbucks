//
//  UserData.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

struct UserData {
    private(set) var token: String?
    private(set) var nickname: String?
    
    mutating func setToken(token: String){
        self.token = token
    }
    
    mutating func setNickName(nickname: String){
        self.nickname = nickname
    }
}
