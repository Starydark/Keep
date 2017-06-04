//
//  LoginViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/3.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Action
    @IBAction func Login(_ sender: AnyObject) {
        if UserName.text == "111" {
            print("login fail")
            self.performSegue(withIdentifier: "login", sender: self)
        }
        else {
            print("login fail")
        }
    }
    @IBAction func Forget(_ sender: UIButton) {
        print("forget")
    }
    @IBAction func SignUp(_ sender: UIButton) {
        print("SignUp")
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
