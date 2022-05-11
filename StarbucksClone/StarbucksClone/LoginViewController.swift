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
