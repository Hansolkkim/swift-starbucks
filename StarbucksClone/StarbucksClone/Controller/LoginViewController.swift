//
//  ViewController.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/09.
//

import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController, DependencySetable {
    typealias DependencyType = LoginDependency
    var dependency: DependencyType? {
        didSet{
            self.loginManagable = dependency?.manager
        }
    }
    private lazy var loginView = LoginView(frame: view.frame)
    private var loginManagable: LoginManagable?

    init() {
        super.init(nibName: nil, bundle: nil)
        DependencyInjector.injecting(to: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        DependencyInjector.injecting(to: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        loginView.action = self
        loginManagable?.setDelegate(delegate: self)
    }
    
    func setDependency(dependency: DependencyType) {
        self.dependency = dependency
    }
}

extension LoginViewController: LoginViewAction {
    func userDidInput(_ input: LoginView.UserAction) {
        switch input {
        case .buttonTapped:
            loginManagable?.kakaoLoginRequest()
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
        loginManagable?.getEventData { result in
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

