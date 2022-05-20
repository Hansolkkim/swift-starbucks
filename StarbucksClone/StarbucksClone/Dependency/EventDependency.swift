//
//  EventDependency.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/16.
//

import Foundation

struct EventDependency: Dependency {
    typealias ManagerType = EventManagable
    let manager: ManagerType
}
