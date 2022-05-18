//
//  HomeUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

protocol HomeManagable {
    func getHomeComponentsData(completion: @escaping (Result<HomeComponents, NetworkError>) -> Void)
}

final class HomeUseCase: HomeManagable {
    private let homeComponentsDataGettable: HomeComponentsGettable
    private let userDefaultManagable: Loginable
    weak var delegate: HomeUseCaseDelegate?

    init(homeComponentsDataGettable: HomeComponentsGettable, userDefaultManagable: Loginable = UserDefaultManager()) {
        self.homeComponentsDataGettable = homeComponentsDataGettable
        self.userDefaultManagable = userDefaultManagable
    }

    func getHomeComponentsData(completion: @escaping (Result<HomeComponents, NetworkError>) -> Void) {
        homeComponentsDataGettable.getHomeComponentsData { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let homeComponentsDTO):
                let nickname = self.userDefaultManagable.getStringFromUserDefault(by: .userNickname) ?? ""
//                let privatelyRecommandedProducts = self.getProductsData(from: homeComponentsDTO.yourRecommand.products)
                let privatelyRecommandedProducts = homeComponentsDTO.yourRecommand.products
                let mainEvent = homeComponentsDTO.mainEvent.imageUploadPath + homeComponentsDTO.mainEvent.mobThumbNailImagePath
//                let currentRecommandedProducts = self.getProductsData(from: homeComponentsDTO.nowRecommand.products)
                let currentRecommandedProducts = homeComponentsDTO.nowRecommand.products

                completion(.success(.init(nickName: nickname, privatelyRecommendedProduct: privatelyRecommandedProducts, mainEventImage: mainEvent, currentRecommendedProduct: currentRecommandedProducts)))

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func getProductsData(from products: [String]) -> [String: ProductDescription] {
        var returnDictionary = [String: ProductDescription]()
        products.forEach { productCD in
            self.homeComponentsDataGettable.getHomeBeveragesData(productCD: productCD, completion: { result in
                switch result {
                case .success(let productInfo):
                    if let imageData = productInfo.0,
                       let uploadPath = imageData.file.first?.imgUploadPath,
                       let filePath = imageData.file.first?.filePath {
                        let imageURL = uploadPath + filePath

                        returnDictionary[productCD] != nil ? (returnDictionary[productCD]?.imageData = imageURL) : (returnDictionary[productCD] = ProductDescription(imageData: imageURL))
                    } else if let infoData = productInfo.1 {
                        let productName = infoData.view.productName

                        returnDictionary[productCD] != nil ? (returnDictionary[productCD]?.title = productName) : (returnDictionary[productCD] = ProductDescription(title: productName))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
        return returnDictionary
    }
}

protocol HomeUseCaseDelegate: AnyObject {
    func updateHomeComponents(_ components: HomeComponents)
}
