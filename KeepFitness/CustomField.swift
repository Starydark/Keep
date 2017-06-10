//
//  CustomField.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/10.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class CustomField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 23.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
    }
}
