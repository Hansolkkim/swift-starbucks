//
//  DependencyInjector.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/16.
//

import Foundation

final class DependencyInjector {
    static func injecting<T: DependencySetable>(to compose: T){
        if compose is SceneDelegate {
            guard let sceneDelegate = compose as? SceneDelegate else { return }
            sceneDelegate.setDependency(dependency: SceneDependency(manager: SceneUseCase(userDefaultManagable: UserDefaultManager(), eventDataGettable: EventRepository(eventService: EventService()))))
        }

        else if compose is LoginViewController {
            guard let loginViewController = compose as? LoginViewController else { return }
            loginViewController.setDependency(dependency: LoginDependency(manager: LoginUseCase(kakaoLoginable: KakaoLogin(), userDefaultManagable: UserDefaultManager(), eventDataGettable: EventRepository(eventService: EventService()))))
        }

        else if compose is EventViewController {
            guard let eventViewController = compose as? EventViewController else { return }
            eventViewController.setDependency(dependency: EventDependency(manager: EventUseCase(userDefaultManagable: UserDefaultManager())))
        }
    }
}


protocol DependencySetable{
    associatedtype DependencyType
    func setDependency(dependency: DependencyType)
    var dependency: DependencyType? { get set }
}

protocol Dependency{
    associatedtype ManagerType
}
