//
//  RecommentCollectionViewDelegate.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/17.
//

import UIKit

final class RecommendCollectionDelegate: NSObject {
}

extension RecommendCollectionDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size")
        return CGSize(width: 100, height: 100)
    }
    
}
