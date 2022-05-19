//
//  HomeEventCollectionDataSource.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import UIKit

final class HomeEventCollectionDataSource: NSObject {
    var events = [HomeEventDescription]()
}

extension HomeEventCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEventCollectionCell.cellIdentifier, for: indexPath) as? HomeEventCollectionCell else {
            return UICollectionViewCell()
        }
        
        let event = events[indexPath.item]
        cell.setInfo(by: event)
        return cell
    }
}
