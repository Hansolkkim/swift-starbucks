//
//  StarbucksCloneTests.swift
//  StarbucksCloneTests
//
//  Created by 김동준 on 2022/05/09.
//

import XCTest
@testable import StarbucksClone

class StarbucksCloneTests: XCTestCase {

    func testFetchEvent() throws {
        let promise = self.expectation(description: "repositoryFetch")
        let eventRepository: EventDataFetchable = EventRepositoryStub(testResult: true)
        eventRepository.fetchData(of: .starbuckstLoading) { result in
            switch result{
            case .success(_):
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testKakaoLogin() throws {
        let kakaoLogin: KakaoLoginable = KakaoLogin()
    }
}
