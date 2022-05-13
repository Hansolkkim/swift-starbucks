//
//  LoginUseCase.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/10.
//
import Foundation

class LoginUseCase{
    private let kakaoLogin = KakaoLogin()
    private let userDefaultManager = UserDefaultManager()
    private let eventRepository = EventRepository()
    private var userData = UserData()
    weak var delegate: LoginUseCaseDelegate?
    
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
                DispatchQueue.main.async {
                    self.delegate?.presentNextViewController(self.selectViewControllerType())
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func selectViewControllerType() -> ViewControllerType {
        if !userDefaultManager.getBooleanFromUserDefault() {
            return .EventViewController
        }

        return .HomeViewController
    }

    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void) {
        eventRepository.getEventData(completion: { result in
            completion(result)
        })
    }
}

protocol LoginUseCaseDelegate: AnyObject {
    func presentNextViewController(_ type: ViewControllerType)
}
