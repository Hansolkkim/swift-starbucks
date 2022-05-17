//
//  EventRepositoryStub.swift
//  StarbucksCloneTests
//
//  Created by 김동준 on 2022/05/17.
//

import Foundation
@testable import StarbucksClone

struct EventRepositoryStub: EventDataFetchable{
    private let testResult: Bool
    init(testResult: Bool){
        self.testResult = testResult
    }
    
    func fetchData(of kind: CodeSquadStarbuckst, completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void) {
        testResult ? completion(.success(StarbuckstDTO(title: "", range: "", target: "", description: "", eventProducts: ""))) : completion(.failure(.noData))
    }
}
