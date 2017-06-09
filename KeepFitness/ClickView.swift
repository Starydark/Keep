//
//  ClickView.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class ClickView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = UIColor.groupTableViewBackground
        //let secondView = ExerciseListTableViewController()
    
        //self.navigationController?.pushViewController(secondView, animated: true)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.15, animations: {
            () -> Void in self.backgroundColor = UIColor.clear
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.15, animations: {
            () -> Void in self.backgroundColor = UIColor.clear
        })
    }
}
