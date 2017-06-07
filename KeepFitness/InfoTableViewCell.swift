//
//  InfoTableViewCell.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/6.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
