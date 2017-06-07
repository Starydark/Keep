//
//  InfoViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/7.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var aciont: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Image.layer.cornerRadius = self.Image.bounds.height / 4
        //self.Image.contentMode = UIViewContentMode.center
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
