//
//  ExerciseListTableViewCell.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/4.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class ExerciseListTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var Action: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
