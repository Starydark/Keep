//
//  DetailTableViewCell.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/8.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellValue: UILabel!
    @IBOutlet weak var Icon: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
