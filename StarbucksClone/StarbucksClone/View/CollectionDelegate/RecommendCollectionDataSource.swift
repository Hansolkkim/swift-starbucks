//
//  RecommendCollectionDataSource.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/17.
//

import UIKit

class RecommendCollectionDataSource: NSObject{
    private(set) var recommends: [RecommendDTO] = []
}
extension RecommendCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommentCollectionCell.cellIdentifier, for: indexPath) as? RecommentCollectionCell else { return UICollectionViewCell() }
        return cell
    }
}
