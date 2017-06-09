//
//  LoginViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/3.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    //MARK: Properties
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    
    var LoginId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.delegate = self
        PassWord.delegate = self
        LoginId = UserName.text!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

    //create foler to store info
    func createFolder(name: String){
        let fileManager = FileManager.default
        //let urlForDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        //let url = urlForDocument[0] as NSURL
        let filePath:String = NSHomeDirectory() + name;
        let exist = fileManager.fileExists(atPath: filePath)
        if !exist {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            print("创建目录成功")
        }
        
    }
    
    //MARK: Action
    @IBAction func Login(_ sender: AnyObject) {
        if UserName.text == "111" {
            createFolder(name: "111")
            LoginId = UserName.text!
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
