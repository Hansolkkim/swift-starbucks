//
//  LoginUseCase.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/10.
//

class LoginUseCase{
    private let kakaoLogin = KakaoLogin()
    private let userDefaultManager = UserDefaultManager()
    private var userData = UserData()
    
    func kakaoLoginRequest(){
        kakaoLogin.loginRequest { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let token):
                self.userData.setToken(token: token)
                self.requestNickName()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestNickName(){
        kakaoLogin.getUserNickname { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let name):
                self.userData.setNickName(nickname: name)
                self.userDefaultManager.saveLoginToken(self.userData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
