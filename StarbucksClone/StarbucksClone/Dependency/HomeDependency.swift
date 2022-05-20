//
//  HomeDependency.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/20.
//

import Foundation

struct HomeDependency: Dependency {
    typealias ManagerType = HomeManagable
    let manager: HomeManagable
}
