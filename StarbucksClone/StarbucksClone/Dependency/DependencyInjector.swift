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
            sceneDelegate.setDependency(dependency: SceneDependency(manager: SceneUseCase(userDefaultManagable: UserDefaultManager())))
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
