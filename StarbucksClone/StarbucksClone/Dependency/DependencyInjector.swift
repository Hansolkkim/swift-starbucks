//
//  DependencyInjector.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/16.
//

import Foundation
import UIKit

final class DependencyInjector {
    private static let dependencyDictionary: [ObjectIdentifier: Any] = [
        ObjectIdentifier(SceneDelegate.self): SceneDependency(manager: SceneUseCase(userDefaultManagable: UserDefaultManager(), eventDataGettable: EventRepository(eventService: EventService()))),
        ObjectIdentifier(LoginViewController.self): LoginDependency(manager: LoginUseCase(kakaoLoginable: KakaoLogin(), userDefaultManagable: UserDefaultManager(), eventDataGettable: EventRepository(eventService: EventService()))),
        ObjectIdentifier(EventViewController.self): EventDependency(manager: EventUseCase(userDefaultManagable: UserDefaultManager())),
        ObjectIdentifier(HomeViewController.self): HomeDependency(manager: HomeUseCase(homeComponentsDataGettable: HomeRepository(homeService: HomeService()))),
        ObjectIdentifier(WhatsNewViewController.self): WhatsNewDependency(manager: WhatsNewUseCase(whatsNewEventGettable: WhatsNewRepository(whatsNewService: WhatsNewService())))]
    
    static func injecting<T: DependencySetable>(to compose: T){
        guard let dependency = dependencyDictionary[ObjectIdentifier(type(of: compose.self))],
              let detailedDependency = dependency as? T.DependencyType else {
                  return
              }
        compose.setDependency(dependency: detailedDependency)
    }
}


protocol DependencySetable: AnyObject {
    associatedtype DependencyType
    func setDependency(dependency: DependencyType)
    var dependency: DependencyType? { get set }
}

protocol Dependency{
    associatedtype ManagerType
}
