//
//  DetailViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/8.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var TitleNmae: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Value: UILabel!
    
    var titleName: String = ""
    var titleValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleNmae.text = titleName
        Name.text = titleName
        Value.text = titleValue
        self.title = titleName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
