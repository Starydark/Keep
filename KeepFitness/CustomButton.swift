//
//  CustomButton.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 23.0
        //layer.borderColor =
            //UIColor(red: 255/255, green: 128/255, blue:0/255, alpha: 1.0).cgColor
        layer.borderWidth = 1.0
        
    }

}
