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
    typealias DependencyType = SceneDependency
    var dependency: DependencyType? {
        didSet{
            self.sceneManagable = dependency?.manager
        }
    }
    
    private var sceneManagable: SceneManagable?
    //private let sceneUseCase = SceneUseCase(userDefaultManagable: UserDefaultManager())
    var window: UIWindow?

    override init(){
        super.init()
        DependencyInjector.injecting(to: self)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        KakaoSDK.initSDK(appKey: appKey)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            guard let selectedViewControllerType = sceneManagable?.selectRootViewController() else { return }
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
extension SceneDelegate: DependencySetable {
    func setDependency(dependency: SceneDependency) {
        self.dependency = dependency
    }
}

extension SceneDelegate {
    private func makeSelectedViewController(by viewControllerType: ViewControllerType) -> UIViewController {
        switch viewControllerType {
        case .LoginViewController:
            return LoginViewController()
        case .EventViewController:
            return makeEventViewController()
        case .HomeViewController:
            return HomeViewController.create()
        }
    }
    
    private func makeEventViewController() -> UIViewController{
        let eventViewController = EventViewController()
        sceneManagable?.getEventData { result in
            switch result{
            case .success(let starbuckst):
                eventViewController.setEventDTO(starbuckstDTO: starbuckst)
            case .failure(let error):
                print(error)
            }
        }
        return eventViewController
    }
}
