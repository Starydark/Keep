//
//  RegisterViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/10.
//  Copyright © 2017年 nju. All rights reserved.
//

import os.log
import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate{

    //MARK: Properties
    @IBOutlet weak var name: CustomField!
    @IBOutlet weak var password: CustomField!
    @IBOutlet weak var password1: CustomField!
    @IBOutlet weak var regButton: CustomButton!
    
    var Register = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        password.delegate = self
        password1.delegate = self
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.name.endEditing(true)
        self.password.endEditing(true)
        self.password1.endEditing(true)
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
        if self.name == textField {
            if userExist() {
                if(Register) {
                    let alert = UIAlertView(title: "错误", message: "用户名已经存在", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    password.isEnabled = false
                    password1.isEnabled = false
                }
            
            }
            else {
                if(!Register) {
                    let alert = UIAlertView(title: "错误", message: "用户名不存在", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                let userid = name.text ?? ""
                password.isEnabled = !userid.isEmpty
                let pw = password.text ?? ""
                password1.isEnabled = !(pw.isEmpty || userid.isEmpty)
            }
        }
        else if self.password == textField {
            let pw = password.text ?? ""
            let userid = name.text ?? ""
            password1.isEnabled = !(pw.isEmpty || userid.isEmpty)
        }
    }
    
    //func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /*if self.password == textField {
            let userid = name.text ?? ""
            password.isEnabled = !userid.isEmpty
            password1.isEnabled = false
        }
        else if self.password1 == textField {
            let pw = password.text ?? ""
            let userid = name.text ?? ""
            password1.isEnabled = !(pw.isEmpty || userid.isEmpty)
        }*/
    }

    //MARK: Action
    @IBAction func register(_ sender: UIButton) {
        let userid = name.text ?? ""
        let pw1 = password.text ?? ""
        let pw2 = password1.text ?? ""
        var error: Bool = true
        let lenght = pw1.characters.count
        if userid.isEmpty {
            let alert = UIAlertView(title: "错误", message: "用户名不能为空", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            error = false
        }
        else if(userExist() && Register){
            let alert = UIAlertView(title: "错误", message: "用户名已经存在", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if (!userExist() && !Register) {
            let alert = UIAlertView(title: "错误", message: "用户名不存在", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if lenght < 6 {
            let alert = UIAlertView(title: "错误", message: "密码长度必须大于6个字符", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            error = false
        }
        else if pw2 != pw1 {
            let alert = UIAlertView(title: "错误", message: "两次输入密码不同", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            error = false
        }
        if error == true {
            if(Register) {
                createFolder()
                self.performSegue(withIdentifier: "RegSuccess", sender: self)
            }
            else {
                let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
                let filePath = DocumentsDirectory.appendingPathComponent(name.text!)
                let ArchiverURL = filePath.appendingPathComponent("password")
                let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(password1.text, toFile: (ArchiverURL.path))
                if isSuccessfulSave{
                    os_log("password successfully changed", log: OSLog.default, type: .debug)
                }
                else {
                    os_log("password to save informations.", log: OSLog.default, type: .error)
                }
                self.performSegue(withIdentifier: "RegSuccess", sender: self)
            }
        }
        else {
            print("false")
        }
    }
    
    func userExist() -> Bool{
        let fileManager = FileManager.default
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        //let DocumentsString = DocumentsDirectory.path
        let filePath = DocumentsDirectory.appendingPathComponent(name.text!)
        //let filePath:String = NSHomeDirectory() + "/" + name.text!;
        let exist = fileManager.fileExists(atPath: filePath.path)
        if exist {
            return true
        }
        else {
            return false
        }
    }
    
    func createFolder(){
        let fileManager = FileManager.default
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = DocumentsDirectory.appendingPathComponent(name.text!)
        //let filePath:String = NSHomeDirectory() + "/" + name.text!;
        print(name.text)
        print(filePath)
        let exist = fileManager.fileExists(atPath: filePath.path)
        if !exist {
            try! fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
            print("创建目录成功")
        }
        //let URL = NSURL(string: filePath)
        let ArchiverURL = filePath.appendingPathComponent("password")
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(password1.text, toFile: (ArchiverURL.path))
        if isSuccessfulSave{
            os_log("password successfully saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("password to save informations.", log: OSLog.default, type: .error)
        }
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
