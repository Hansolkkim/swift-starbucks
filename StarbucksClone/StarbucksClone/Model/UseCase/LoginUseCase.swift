//
//  LoginUseCase.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/10.
//
import Foundation

protocol LoginManagable {
    func setDelegate(delegate: LoginUseCaseDelegate)
    func kakaoLoginRequest()
    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void)
}

final class LoginUseCase {
    private let kakaoLoginable: KakaoLoginable
    private let userDefaultManagable: LoginUserDefaultManagable
    private let eventDataGettable: EventDataGettable
    private var userData = UserData()
    weak var delegate: LoginUseCaseDelegate?
    
    init(kakaoLoginable: KakaoLoginable, userDefaultManagable: LoginUserDefaultManagable, eventDataGettable: EventDataGettable){
        self.kakaoLoginable = kakaoLoginable
        self.userDefaultManagable = userDefaultManagable
        self.eventDataGettable = eventDataGettable
    }

    private func requestNickName(){
        kakaoLoginable.getUserNickname { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let name):
                self.userData.setNickName(nickname: name)
                self.userDefaultManagable.saveLoginToken(self.userData)
                DispatchQueue.main.async {
                    self.delegate?.presentNextViewController(self.selectViewControllerType())
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func selectViewControllerType() -> ViewControllerType {
        if !userDefaultManagable.getBooleanFromUserDefault() {
            return .EventViewController
        }
        return .HomeViewController
    }
}

extension LoginUseCase: LoginManagable {
    func setDelegate(delegate: LoginUseCaseDelegate){
        self.delegate = delegate
    }
    
    func kakaoLoginRequest(){
        kakaoLoginable.loginRequest { [weak self] result in
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
    
    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void) {
        eventDataGettable.getEventData(completion: { result in
            completion(result)
        })
    }
}

protocol LoginUseCaseDelegate: AnyObject {
    func presentNextViewController(_ type: ViewControllerType)
}
