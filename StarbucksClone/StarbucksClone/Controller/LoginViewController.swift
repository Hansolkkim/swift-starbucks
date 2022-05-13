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
        var nextViewController: UIViewController

        switch type {
        case .LoginViewController:
            return
        case .EventViewController:
            nextViewController =  EventViewController()
            usecase.getEventData { result in
                switch result{
                case .success(let starbuckst):
                    let eventViewController = nextViewController as? EventViewController
                    eventViewController?.setEventDTO(starbuckstDTO: starbuckst)
                case .failure(let error):
                    print(error)
                }
            }
        case .HomeViewController:
            nextViewController =  EventViewController() // HomeViewController 구현 후 변경
        }

        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
}
