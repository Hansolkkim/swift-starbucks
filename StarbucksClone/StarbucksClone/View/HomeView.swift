//
//  HomeView.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/17.
//

import SnapKit

final class HomeView: UIView {

    weak var action: HomeViewAction?
    
    let scrollView = UIScrollView()

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    var recommandCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 160)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecommentCollectionCell.self, forCellWithReuseIdentifier: RecommentCollectionCell.cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton()

        let title = "See all"
        let font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        let attributedTitle = NSMutableAttributedString(string: title)
        attributedTitle.addAttribute(.font, value: font, range: .init(0..<title.count))

        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.starbuckstButtonGreen, for: .normal)
        return button
    }()

    var homeEventCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeEventCollectionCell.self, forCellWithReuseIdentifier: HomeEventCollectionCell.cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var popularMenuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 160)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecommentCollectionCell.self, forCellWithReuseIdentifier: RecommentCollectionCell.cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let deliveryView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "Delivery"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let deliveryImageView: UIImageView = {
        let deliveryImageView = UIImageView()
        deliveryImageView.image = UIImage(systemName: "bicycle")
        deliveryImageView.contentMode = .scaleAspectFit
        deliveryImageView.tintColor = .white
        deliveryImageView.image?.withTintColor(.white)
        return deliveryImageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
        addAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        addAction()
    }
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(scrollView)
        addSubview(deliveryView)
        scrollView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
        scrollView.contentSize.height = 1000
        scrollView.contentSize.width = self.frame.width
        scrollView.backgroundColor = .white
        scrollView.addSubViews(nicknameLabel, recommandCollectionView, eventImageView, homeEventCollectionView)
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.leading.equalTo(scrollView.snp.leading).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(250)
        }
        
        recommandCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(160)
        }
        
        eventImageView.snp.makeConstraints { make in
            make.top.equalTo(recommandCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(400)
        }
        
        deliveryView.addSubViews(deliveryLabel, deliveryImageView)
        
        deliveryView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(150)
        }
        deliveryView.backgroundColor = UIColor.starbuckstButtonGreen
        
        deliveryImageView.snp.makeConstraints { make in
            make.leading.equalTo(deliveryView.snp.leading).offset(10)
            make.centerY.equalTo(deliveryView.snp.centerY)
            make.width.height.equalTo(45)
        }
        
        deliveryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryView.snp.centerY)
            make.width.equalTo(80)
            make.leading.equalTo(deliveryImageView.snp.trailing).offset(5)
        }

        homeEventCollectionView.snp.makeConstraints { make in
            make.top.equalTo(eventImageView.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(300)
        }

        homeEventCollectionView.addSubview(seeAllButton)

        seeAllButton.snp.makeConstraints { make in
            make.top.equalTo(homeEventCollectionView.frameLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(homeEventCollectionView.frameLayoutGuide.snp.trailing)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
}
extension HomeView {
    func setNickNameLabel(title: String) {
        DispatchQueue.main.async { [weak self] in
            self?.nicknameLabel.text = title
        }
    }
    
    func setRecommendCollectionDatasource(dataSource: UICollectionViewDataSource) {
        self.recommandCollectionView.dataSource = dataSource
    }
    
    func updateImageView(data: Data){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let eventImage = UIImage(data: data) else { return }
            self.eventImageView.image = eventImage
            
            let ratio = eventImage.size.height / eventImage.size.width
            let newWidth = self.safeAreaLayoutGuide.layoutFrame.width
            let newHeight = newWidth * ratio
            
            self.eventImageView.snp.remakeConstraints { make in
                make.height.equalTo(newHeight)
                make.top.equalTo(self.recommandCollectionView.snp.bottom).offset(10)
                make.leading.equalTo(self.snp.leading).offset(10)
                make.trailing.equalTo(self.snp.trailing).offset(-10)
            }
        }
    }
    
    func unfoldingDelivaryView(){
        deliveryView.snp.remakeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(150)
        }
        deliveryView.addSubview(deliveryLabel)
        deliveryLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(deliveryView.snp.centerY)
            make.width.equalTo(80)
            make.leading.equalTo(deliveryImageView.snp.trailing).offset(5)
        }
        
        deliveryImageView.snp.remakeConstraints { make in
            make.leading.equalTo(deliveryView.snp.leading).offset(10)
            make.centerY.equalTo(deliveryView.snp.centerY)
            make.width.height.equalTo(50)
        }

    }

    func setHomeEventCollectionDataSource(dataSource: UICollectionViewDataSource) {
        homeEventCollectionView.dataSource = dataSource
    }

    private func addAction() {
        seeAllButton.addAction(UIAction(handler: { [weak self] _ in
            self?.action?.userDidInput(.whatsNewButtonTapped)
        }), for: .touchUpInside)
    }
    
    func foldingDelivaryView(){
        deliveryView.snp.remakeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.height.equalTo(60)
        }
        
        deliveryImageView.snp.remakeConstraints { make in
            make.top.leading.equalTo(deliveryView).offset(5)
            make.center.equalTo(deliveryView.snp.center)
        }
        
        deliveryLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(deliveryView.snp.centerY)
            make.width.equalTo(0)
            make.leading.equalTo(deliveryImageView.snp.trailing).offset(10)
            make.trailing.equalTo(deliveryView.snp.trailing).offset(-10)
        }
        
    }
    
}

extension HomeView {
    enum UserAction {
        case whatsNewButtonTapped
    }
}

protocol HomeViewAction: AnyObject{
    func userDidInput(_ input: HomeView.UserAction)
}
