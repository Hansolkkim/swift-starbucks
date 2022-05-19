//
//  WhatsNewView.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import UIKit

final class WhatsNewView: UIView {
    
    var eventCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 400, height: 85)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WhatsNewCollectionCell.self, forCellWithReuseIdentifier: WhatsNewCollectionCell.cellIdentifier)
        
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .white
        addSubview(eventCollectionView)
        eventCollectionView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        eventCollectionView.contentSize.height = self.frame.height
        eventCollectionView.contentSize.width = self.frame.width
        eventCollectionView.backgroundColor = .white
    }
}

extension WhatsNewView {
    func setEventCollectionDataSource(dataSource: UICollectionViewDataSource) {
        eventCollectionView.dataSource = dataSource
    }
}
