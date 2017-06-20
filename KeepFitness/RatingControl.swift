//
//  RatingControl.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/20.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
    @IBInspectable var starCount: Int = 5
    
    //MARK:Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filled = UIImage(named: "filled", in: bundle, compatibleWith: self.traitCollection)
        let empty = UIImage(named: "empty", in: bundle, compatibleWith: self.traitCollection)
        
        if let saveTime = loadTime(){
            rating = saveTime
        }
        else {
            rating = 40
        }
        
        let count = rating / 30
        
        for _ in 0..<count {
            let button = UIButton()
            button.setImage(filled, for: .normal)
            
            //button.backgroundColor = UIColor.red
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        
        for _ in count..<starCount {
            let button = UIButton()
            button.setImage(empty, for: .normal)
            
            //button.backgroundColor = UIColor.red
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    private func loadTime() -> Int? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Information.XArchiverURL.path)) as? Int
    }
}
