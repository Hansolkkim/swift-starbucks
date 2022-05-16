//
//  UserDefaultManager.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

protocol Loginable {
    func getStringFromUserDefault(by keyType: UserDefaultManager.KeyType) -> String?
}

protocol LoginDataSavable {
    func saveLoginToken(_ tokenData: UserData)
}

protocol EventNeverSeeable {
    func getBooleanFromUserDefault() -> Bool
}

protocol EventNeverSeeDataSavable {
    func saveEventNeverSeeAgain()
}

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

extension UserDefaultManager: EventNeverSeeable {
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
