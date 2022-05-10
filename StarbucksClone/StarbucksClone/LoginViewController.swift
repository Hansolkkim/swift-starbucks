//
//  ViewController.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/09.
//

import UIKit

class LoginViewController: UIViewController {

    private lazy var loginView = LoginView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view = loginView
        loginView.action = self
    }
}

extension LoginViewController: LoginViewAction {
    func userDidInput(_ input: LoginView.UserAction) {
        switch input {
        case .buttonTapped:
            print("button tapped")
        }
    }
}
