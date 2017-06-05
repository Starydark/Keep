//
//  ExerciseViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/4.
//  Copyright © 2017年 nju. All rights reserved.
//

import os.log
import UIKit

class ExerciseViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Action: UITextField!
    @IBOutlet weak var StartTime: UITextField!
    @IBOutlet weak var EndTime: UITextField!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var dataPicker = UIDatePicker()
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.delegate = self
        var rect: CGRect
        rect =  Name.frame
        rect.size.height = 50
        Name.frame = rect
        Action.delegate = self
        
        if let exercise = exercise {
            navigationItem.title = exercise.Name
            Name.text = exercise.Name
            Action.text = exercise.Action
            photo.image = exercise.photo
            StartTime.text = exercise.StartTime
            EndTime.text = exercise.EndTime
        }
        
        updateSaveButtonState()
        
        //MARK: 时间选择器属性及样式
        //dataPicker.locale = NSLocale(localeIdentifier: "zh_cn") as Locale
        dataPicker.timeZone = NSTimeZone.system
        dataPicker.datePickerMode = UIDatePickerMode.time
        dataPicker.addTarget(self, action: #selector(getDate), for: UIControlEvents.valueChanged)
        dataPicker.layer.backgroundColor = UIColor.white.cgColor
        dataPicker.layer.masksToBounds = true
        
        //MARK: 修改textfield点击效果为时间选择器
        StartTime.inputView = dataPicker
        EndTime.inputView = dataPicker
        
        // Do any additional setup after loading the view.
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    //MARK: Private Methods
    private func updateSaveButtonState() {
        let text = Name.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: 日期选择器选择处理方法
    func getDate(dataPicker: UIDatePicker){
        let formatter = DateFormatter()
        let date = dataPicker.date
        formatter.dateFormat = "HH:mm"
        let dateStr = formatter.string(from: date)
        if StartTime.isEditing {
            self.StartTime.text = dateStr
        }
        else if EndTime.isEditing {
            self.EndTime.text = dateStr
        }
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photo.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    //MARK: Navigation
    @IBAction func cancle(_ sender: UIBarButtonItem) {
        let isPresentingInAddmealMode = presentingViewController is UINavigationController
        if isPresentingInAddmealMode {
           dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The mealViewController is not inside a navigation controller.")
        }
        
    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = Name.text ?? ""
        let photoimage = photo.image
        let action = Action.text
        let starttime = StartTime.text
        let endtime = EndTime.text
        
        exercise = Exercise(Name: name, photo: photoimage, Action: action!, StartTime: starttime!, EndTime: endtime!)
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
