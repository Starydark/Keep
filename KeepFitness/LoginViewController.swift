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
    @IBOutlet weak var forget: UIButton!
    @IBOutlet weak var register: UIButton!
    
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
    func CorrectPassword(name: String) -> Bool{
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = DocumentsDirectory.appendingPathComponent(name);
        let ArchiverURL = filePath.appendingPathComponent("password")
        let GetPassword = NSKeyedUnarchiver.unarchiveObject(withFile: (ArchiverURL.path)) as? String
        if GetPassword == PassWord.text {
            return true
        }
        return false
        
    }
    
    func UserExist(name: String) -> Bool {
        let fileManager = FileManager.default
        //let filePath:String = NSHomeDirectory() + "/" + name;
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = DocumentsDirectory.appendingPathComponent(name)
        //print(filePath)
        let exist = fileManager.fileExists(atPath: filePath.path)
        if exist {
            return true
        }
        else {
            return false
        }
    }
    
    //MARK: Action
    @IBAction func Login(_ sender: AnyObject) {
        let userId = UserName.text ?? ""
        if userId.isEmpty{
            let alert = UIAlertView(title: "错误", message: "用户名不能为空", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if !UserExist(name: userId) {
            let alert = UIAlertView(title: "错误", message: "用户不存在", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if CorrectPassword(name: userId) {
            LoginId = UserName.text!
            self.performSegue(withIdentifier: "login", sender: self)
        }
        else {
            let alert = UIAlertView(title: "错误", message: "密码错误", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    @IBAction func Forget(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Register", sender: self)
        //self.present(regView, animated: true, completion: nil)
    }
    @IBAction func SignUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Register", sender: self)
    }
  
    @IBAction func unwindToLogin(sender: UIStoryboardSegue){
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "Forget":
            let controller = segue.destination as! RegisterViewController
            controller.title = "忘记密码"
        case "Register":
            let controller = segue.destination as! RegisterViewController
            controller.title = "注册"
            controller.Register = true
        default:
            print(segue.identifier)
        }
    }
    

}
