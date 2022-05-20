//
//  WhatNewDependency.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/20.
//

import Foundation

struct WhatsNewDependency: Dependency {
    typealias ManagerType = WhatsNewManagable
    let manager: ManagerType
}
