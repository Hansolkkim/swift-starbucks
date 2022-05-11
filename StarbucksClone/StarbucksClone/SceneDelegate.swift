//
//  SceneDelegate.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/09.
//

import KakaoSDKAuth
import KakaoSDKCommon

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let appKey = "9d618f74a6d63d44fe745da0f480233f"
    private let sceneUseCase = SceneUseCase()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        KakaoSDK.initSDK(appKey: appKey)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let selectedViewControllerType = sceneUseCase.selectRootViewController()
            window.rootViewController = makeSelectedViewController(by: selectedViewControllerType)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        if AuthApi.isKakaoTalkLoginUrl(url) {
            _ = AuthController.handleOpenUrl(url: url)
        }
    }
}

extension SceneDelegate {
    private func makeSelectedViewController(by viewControllerType: ViewControllerType) -> UIViewController {
        switch viewControllerType {
        case .LoginViewController:
            return LoginViewController()
        case .EventViewController:
            return LoginViewController() // EventViewController 구현 후 수정 예정
        case .HomeViewController:
            return LoginViewController() // HomeViewController 구현 후 수정 예정
        }
    }
}
