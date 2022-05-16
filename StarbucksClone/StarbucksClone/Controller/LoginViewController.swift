//
//  ViewController.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/09.
//

import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    private lazy var loginView = LoginView(frame: view.frame)
    private let usecase = LoginUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        loginView.action = self
        usecase.delegate = self
    }
}

extension LoginViewController: LoginViewAction {
    func userDidInput(_ input: LoginView.UserAction) {
        switch input {
        case .buttonTapped:
            usecase.kakaoLoginRequest()
        }
    }
}

extension LoginViewController: LoginUseCaseDelegate {
    func presentNextViewController(_ type: ViewControllerType) {
        switch type {
        case .EventViewController:
            presentEventViewController()
        case .HomeViewController:
            present(HomeViewController.create(), animated: true, completion: nil)
        default:
            return
        }
    }
    
    private func presentEventViewController(){
        usecase.getEventData { result in
            switch result{
            case .success(let starbuckst):
                DispatchQueue.main.async { [weak self] in
                    let eventViewController = EventViewController()
                    eventViewController.setEventDTO(starbuckstDTO: starbuckst)
                    eventViewController.modalPresentationStyle = .fullScreen
                    self?.present(eventViewController, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

