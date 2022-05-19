//
//  HomeScrollViewDelegate.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/19.
//

import UIKit

protocol HomeScrollActionDeleagte: AnyObject {
    func scrollMoveUp()
    func scrollMoveDown()
}

final class HomeScrollViewDelegate: NSObject {
    private var lastContentOffset: CGFloat = 0
    weak var delegate: HomeScrollActionDeleagte?
}
extension HomeScrollViewDelegate: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < bottomOffset.y {
            if (self.lastContentOffset > scrollView.contentOffset.y) {
                delegate?.scrollMoveUp()
            }
            else if (self.lastContentOffset < scrollView.contentOffset.y) {
                delegate?.scrollMoveDown()
            }
            self.lastContentOffset = scrollView.contentOffset.y
        }
    }
}

