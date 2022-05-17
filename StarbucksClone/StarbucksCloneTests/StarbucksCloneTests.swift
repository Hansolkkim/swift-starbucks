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
        let kakaoLogin: KakaoLoginable = KakaoLoginStub(isSuccess: true)

        let promise1 = expectation(description: "Login Success")
        let promise2 = expectation(description: "Nickname is came")

        kakaoLogin.loginRequest { result in
            switch result {
            case .success(let string):
                XCTAssertEqual(string, "Login Success")
            case .failure(let error):
                XCTAssertEqual(error, .nilUserError)
            }
            promise1.fulfill()
        }

        kakaoLogin.getUserNickname { result in
            switch result {
            case .success(let string):
                XCTAssertEqual(string, "Nickname is came")
            case .failure(let error):
                XCTAssertEqual(error, .nilNicknameError)
            }
            promise2.fulfill()
        }

        wait(for: [promise1, promise2], timeout: 5)
    }
}
