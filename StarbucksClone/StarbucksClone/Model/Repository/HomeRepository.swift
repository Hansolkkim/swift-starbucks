//
//  HomeRepository.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

protocol HomeComponentsGettable {
    func getHomeComponentsData()
    mutating func setDelegate(delegate: HomeRepositoryDelegate)
}

struct HomeRepository: HomeComponentsGettable {

    let homeService: HomeComponentsDataFetchable
    var delegate: HomeRepositoryDelegate?
    
    init(homeService: HomeComponentsDataFetchable) {
        self.homeService = homeService
    }
    
    mutating func setDelegate(delegate: HomeRepositoryDelegate){
        self.delegate = delegate
    }
    
    func getHomeComponentsData() {
        homeService.fetchData(of: .fetchHomeComponents) { (result: Result<HomeComponentsDTO, NetworkError>) in
            switch result {
            case .success(let homeDTO):
                getImage(by: homeDTO.mainEvent.imageUploadPath + homeDTO.mainEvent.mobThumbNailImagePath)
                getYourRecommandProducts(products: homeDTO.yourRecommand.products)
            case .failure(let error):
                delegate?.getHomeComponentsDataError(error: error)
            }
        }
    }
    
    private func getImage(by url: String){
        homeService.fetchImage(of: url) { result in
            switch result {
            case .success(let data):
                delegate?.updateEventImage(data: data)
            case .failure(let error):
                delegate?.getImageDataError(error: error)
            }
        }
    }
    
    private func getYourRecommandProducts(products: [String]){
        for product in products {
            getBeverageData(productCD: product)
        }
    }
    
    private func getBeverageData(productCD: String){
        let group = DispatchGroup()
        let serialQueue = DispatchQueue.init(label: "SerialQueue")
        var dto = RecommendDTO(title: "", imageURL: "")
        group.enter()
        homeService.fetchData(of: .fetchBeverageImages(productCD)) { (result: Result<BeverageImageDTO, NetworkError>) in
            switch result{
            case .success(let imageDTO):
                guard let imageUploadPath = imageDTO.file.first?.imgUploadPath,
                      let imageFilePath = imageDTO.file.first?.filePath else {
                          return
                      }
                serialQueue.async {
                    dto.imageURL = imageUploadPath + imageFilePath
                }
            case .failure(let error):
                delegate?.getBeverageError(error: error)
            }
            
            if dto.title != ""{
                group.leave()
            }
        }
        
        homeService.fetchData(of: .fetchBeverageInfo(productCD)) { (result: Result<BeverageInfoDTO, NetworkError>) in
            switch result{
            case .success(let infoDTO):
                serialQueue.async {
                    dto.title = infoDTO.view.productName
                }
            case .failure(let error):
                delegate?.getBeverageError(error: error)
            }
            
            if dto.imageURL != ""{
                group.leave()
            }
        }
        
        let queueForGroup = DispatchQueue(label: "endQueue", attributes: .concurrent)
        group.notify(queue: queueForGroup) {
            homeService.fetchImage(of: dto.imageURL) { result in
                switch result{
                case .success(let data):
                    let entity = ProductDescription(title: dto.title, imageData: data)
                    delegate?.updateBeverageData(product: entity)
                case .failure(let error):
                    delegate?.getBeverageError(error: error)
                }
            }
        }
    }
}

protocol HomeRepositoryDelegate: AnyObject{
    func updateEventImage(data: Data)
    func getImageDataError(error: NetworkError)
    func getHomeComponentsDataError(error: NetworkError)
    func getBeverageError(error: NetworkError)
    func updateBeverageData(product: ProductDescription)
}
