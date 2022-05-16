//
//  LoginDependency.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/16.
//

import Foundation

struct LoginDependency: Dependency {
    typealias ManagerType = LoginManagable
    let manager: LoginManagable
}
