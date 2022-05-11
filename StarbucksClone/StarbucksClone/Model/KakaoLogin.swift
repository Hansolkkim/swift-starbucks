//
//  KakaoLogin.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/10.
//

import KakaoSDKAuth
import KakaoSDKUser

struct KakaoLogin {
    func loginRequest(completion: @escaping (Result<String, KakaoLoginError>) -> ()){
        let loginApiCompletion: (OAuthToken?, Error?) -> () = { (oauthToken, error) in
            DispatchQueue.global().async {
                guard let accessToken = oauthToken?.accessToken else {
                    return completion(.failure(.invailedAccessToken))
                }
                completion(.success(accessToken))
            }
        }
        UserApi.shared.loginWithKakaoAccount(nonce: nil, completion: loginApiCompletion)
    }
    
    func getUserNickname(completion: @escaping (Result<String, KakaoLoginError>) -> ()) {
        let nicknameApiCompletion: (User?, Error?) -> Void = {
            user, error in
            DispatchQueue.global().async {
                guard let user = user, let account = user.kakaoAccount else {
                    return completion(.failure(.nilUserError))
                }
                guard let profile = account.profile, let nickname = profile.nickname else {
                    return completion(.failure(.nilNicknameError))
                }
                completion(.success(nickname))
            }
        }
        DispatchQueue.global().async {
            UserApi.shared.me(completion: nicknameApiCompletion)
        }
    }
}

enum KakaoLoginError: Error{
    case invailedAccessToken
    case nilUserError
    case nilNicknameError
    case nilAccount
}
