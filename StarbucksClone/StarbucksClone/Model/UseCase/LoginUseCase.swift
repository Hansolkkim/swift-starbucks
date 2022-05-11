//
//  LoginUseCase.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/10.
//

class LoginUseCase{
    private let kakaoLogin = KakaoLogin()
    
    func kakaoLoginRequest(){
        kakaoLogin.loginRequest { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let token):
                print("\(token) Success")
                self.requestNickName()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestNickName(){
        kakaoLogin.getUserNickname { result in
            switch result{
            case .success(let name):
                print("nickname \(name) success")
            case .failure(let error):
                print(error)
            }
        }
    }
}
