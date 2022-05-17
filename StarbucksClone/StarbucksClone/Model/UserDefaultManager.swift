//
//  UserDefaultManager.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

protocol Loginable { // scene에서 사용될 기능.
    func getStringFromUserDefault(by keyType: UserDefaultManager.KeyType) -> String?
}

protocol LoginDataSavable { // 로그인 화면에서 사용될 기능.
    func saveLoginToken(_ tokenData: UserData)
}

protocol EventUserDefaultGettable { // 이벤트 화면에서 사용될 기능.
    func getBooleanFromUserDefault() -> Bool
}

protocol EventNeverSeeDataSavable { // scene, login에서 사용할 기능.
    func saveEventNeverSeeAgain()
}

typealias SceneUserDefaultManagable = Loginable & EventUserDefaultGettable

typealias LoginUserDefaultManagable = LoginDataSavable & EventUserDefaultGettable

struct UserDefaultManager {
    private let userDefault = UserDefaults.standard
}

extension UserDefaultManager: Loginable {
    func getStringFromUserDefault(by keyType: KeyType) -> String? {
        return userDefault.string(forKey: keyType.key)
    }
}
extension UserDefaultManager: LoginDataSavable {
    func saveLoginToken(_ tokenData: UserData) {
        userDefault.set(tokenData.token, forKey: KeyType.userLoginToken.key)
        userDefault.set(tokenData.nickname, forKey: KeyType.userNickname.key)
    }
}

extension UserDefaultManager: EventUserDefaultGettable {
    func getBooleanFromUserDefault() -> Bool {
        return userDefault.bool(forKey: KeyType.eventNeverSeeAgain.key)
    }
}

extension UserDefaultManager: EventNeverSeeDataSavable {
    func saveEventNeverSeeAgain() {
        userDefault.set(true, forKey: KeyType.eventNeverSeeAgain.key)
    }
}

extension UserDefaultManager {
    enum KeyType {
        case userLoginToken
        case userNickname
        case eventNeverSeeAgain

        var key: String {
            switch self {
            case .userLoginToken:
                return "UserToken"
            case .userNickname:
                return "UserNickname"
            case .eventNeverSeeAgain:
                return "EventNeverSeeAgain"
            }
        }
    }
}
