//
//  ViewController.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/09.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    private lazy var loginView = LoginView(frame: view.frame)

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
            let appleIdProvider = ASAuthorizationAppleIDProvider()
            let request = appleIdProvider.createRequest()
            request.requestedScopes = [.fullName]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = view.window else {
            print("asd")
            return ASPresentationAnchor()
        }
        return window
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:

            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
        default:
            break
        }
    }
}
