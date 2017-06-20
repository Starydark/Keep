//
//  TotalTimeViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/20.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class TotalTimeViewController: UIViewController {

    @IBOutlet weak var totalTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let saveTime = loadTime() {
            totalTime.text = String(saveTime) + "s"
        }
        else {
            totalTime.text = "0s"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadTime() -> Int? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Information.XArchiverURL.path)) as? Int
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
