//
//  DetailViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/8.
//  Copyright © 2017年 nju. All rights reserved.
//

import os.log
import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    
    //MARK: Properties
    @IBOutlet weak var TitleNmae: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Value: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var changeValue: String?
    
    var titleName: String = ""
    var titleValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Value.delegate = self
        if !titleName.isEmpty {
            TitleNmae.text = titleName
            Name.text = titleName
            self.title = titleName
        }
        if !titleValue.isEmpty{
            Value.text = titleValue
        }
        updateSaveButtonState()
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
        updateSaveButtonState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState(){
        let text = Value.text ?? ""
        if titleName == "简介" {
            print("yes1")
            saveButton.isEnabled = true
        }
        else {
            print("yes2")
            saveButton.isEnabled = !text.isEmpty
        }
    }

    
    // MARK: - Navigation
    // MARK: Actions
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBAction func cancle(_ sender: UIBarButtonItem) {
        let isPresentingInDetail = presentingViewController is UINavigationController
        if isPresentingInDetail{
            dismiss(animated: true, completion: nil)
        }
        else if let owningnavigationController = navigationController {
            owningnavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The DetailViewController is not inside a navigation controller.")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        changeValue = Value.text
    }
    

}
