//
//  KakaoLoginStub.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

struct KakaoLoginStub: KakaoLoginable {
    private var isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func loginRequest(completion: @escaping (Result<String, KakaoLoginError>) -> ()) {
        isSuccess ? completion(.success("Login Success")) : completion(.failure(.nilUserError))
    }
    
    func getUserNickname(completion: @escaping (Result<String, KakaoLoginError>) -> ()) {
        isSuccess ? completion(.success("Nickname is came")) : completion(.failure(.nilNicknameError))
    }
}
