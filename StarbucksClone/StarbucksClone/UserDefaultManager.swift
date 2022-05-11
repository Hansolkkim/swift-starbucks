//
//  UserDefaultManager.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

struct UserDefaultManager {
    private let userDefault = UserDefaults.standard
}

extension UserDefaultManager {
    func getStringFromUserDefault(by keyType: KeyType) -> String? {
        return userDefault.string(forKey: keyType.key)
    }

    func saveLoginToken(_ tokenData: UserData) {
        userDefault.set(tokenData.token, forKey: KeyType.userLoginToken.key)
        userDefault.set(tokenData.nickname, forKey: KeyType.userNickname.key)
    }
}

extension UserDefaultManager {
    func getBooleanFromUserDefault() -> Bool {
        return userDefault.bool(forKey: KeyType.eventNeverSeeAgain.key)
    }

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
