//
//  SceneUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

class SceneUseCase {
    private let userDefaultManager = UserDefaultManager()

    func selectRootViewController() -> ViewControllerType {
        guard let loginResult = userDefaultManager.getStringFromUserDefault(by: .userLoginToken) else {
            return .LoginViewController
        }
        guard let eventResult = userDefaultManager.getStringFromUserDefault(by: .userLoginToken) else {
            return .EventViewController
        }
        return .HomeViewController
    }
}

enum ViewControllerType {
    case LoginViewController
    case EventViewController
    case HomeViewController
}
