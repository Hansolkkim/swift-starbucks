//
//  UIView.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/18.
//

import UIKit

extension UIView{
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
