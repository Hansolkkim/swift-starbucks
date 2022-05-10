//
//  LoginView.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/10.
//

import SnapKit
import Foundation
import UIKit

class LoginView: UIView {
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Apple ID로 로그인", for: .normal)
        button.layer.borderWidth = 1.0
        return button
    }()

    weak var action: LoginViewAction?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        addAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        setupLayout()
        addAction()
    }

    private func setupLayout() {
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
    }

    private func addAction() {
        loginButton.addAction(UIAction (handler: { [weak self] _ in
            self?.action?.userDidInput(.buttonTapped)
        }) , for: .touchUpInside)
    }
}

extension LoginView {
    enum UserAction {
        case buttonTapped
    }
}

protocol LoginViewAction: AnyObject {
    func userDidInput(_ input: LoginView.UserAction)
}
