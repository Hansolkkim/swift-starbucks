//
//  SceneDelegate.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/09.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        KakaoSDK.initSDK(appKey: "9d618f74a6d63d44fe745da0f480233f")
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = LoginViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
        print("url \(URLContexts.first?.url)")
    }
}
