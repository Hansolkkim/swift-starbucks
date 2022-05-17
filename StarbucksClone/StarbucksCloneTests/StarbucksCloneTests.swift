//
//  StarbucksCloneTests.swift
//  StarbucksCloneTests
//
//  Created by 김동준 on 2022/05/09.
//

import XCTest
@testable import StarbucksClone

class StarbucksCloneTests: XCTestCase {

    func testSceneUserDefault() throws {
        let userDefault: SceneUserDefaultManagable = UserDefaultManager()
    }
    
    func testLoginUserDefault() throws {
        let userDefault: LoginUserDefaultManagable = UserDefaultManager()
    }
    
    func testEventDataFetch() throws{
        let service: EventDataFetchable = EventService()
    }
    
    func testKakaoLogin() throws {
        let kakaoLogin: KakaoLoginable = KakaoLogin()
    }
}
