//
//  HomeView.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/17.
//

import SnapKit

final class HomeView: UIView {
    
    private let scrollView = UIScrollView()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "Solbony님을 위한 추천 메뉴"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    var recommandCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecommentCollectionCell.self, forCellWithReuseIdentifier: RecommentCollectionCell.cellIdentifier)
        let delegate = RecommendCollectionDelegate()
        collectionView.delegate = delegate
        return collectionView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
        scrollView.contentSize.height = 1000
        scrollView.contentSize.width = self.frame.width
        scrollView.backgroundColor = .white
        scrollView.addSubViews(nicknameLabel, recommandCollectionView)
        
        
        nicknameLabel.backgroundColor = .yellow
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
        recommandCollectionView.backgroundColor = .blue
        
        print(recommandCollectionView.description)
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
    
}
