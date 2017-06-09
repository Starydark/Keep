//
//  CustomView.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class CustomView: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = 4.0
        //        layer.shadowColor = UIColor(red: CGFloat(157.0) / 255.0, green: CGFloat(157.0) / 255.0, blue: CGFloat(157.0) / 255.0, alpha: 0.9).CGColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
    }
}
