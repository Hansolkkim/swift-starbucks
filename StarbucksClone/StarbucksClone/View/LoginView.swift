//
//  LoginView.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/10.
//

import SnapKit

class LoginView: UIView {
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "kakaoLogo"), for: .normal)
        button.tintColor = .black
        button.setTitle(" Kakao ID로 로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        button.clipsToBounds = true
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.layer.cornerRadius = 15
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
            make.width.equalTo(200)
            make.height.equalTo(40)
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
