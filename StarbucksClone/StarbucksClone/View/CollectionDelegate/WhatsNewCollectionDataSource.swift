//
//  WhatsNewCollectionDataSource.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import UIKit

final class WhatsNewCollectionDataSource: NSObject {
    var events = [WhatsNewEventDescription?]()
}

extension WhatsNewCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhatsNewCollectionCell.cellIdentifier, for: indexPath) as? WhatsNewCollectionCell else {
            return UICollectionViewCell()
        }

        if let event = events[indexPath.item] {
            cell.setInfo(by: event)
        }

        return cell
    }
}
