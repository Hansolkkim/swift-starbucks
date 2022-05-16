//
//  SceneDependency.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/16.
//

import Foundation

struct SceneDependency: Dependency{
    typealias ManagerType = SceneManagable
    let manager: SceneManagable
}
