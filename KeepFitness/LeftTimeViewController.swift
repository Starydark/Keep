//
//  LeftTimeViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/20.
//  Copyright © 2017年 nju. All rights reserved.
//
import os.log
import UIKit

class LeftTimeViewController: UIViewController {

    @IBOutlet weak var LeftTime: UILabel!
    @IBOutlet weak var times: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var loop: UILabel!
    
    var exercises = [Exercise]()
    var exercise: Exercise?
    var exercisetime = 0
    
    var left = 5
    var totimes = 3
    var timer :Timer!
    var time1 = 10
    var time2 = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LeftTime.text = String(left)
        loop.text = "还剩\(totimes)次循环"
        btn.setTitle("开始", for: .normal)
        btn.layer.cornerRadius = btn.frame.width/2
        btn.layer.borderWidth = 1.0
        btn.addTarget(self, action: #selector(startClicked), for: .touchUpInside)
        //self.view.addSubview(btn)
        if let saveExercises = loadExercises() {
            exercises += saveExercises
        }
        time1 = left
        time2 = totimes
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if((timer) != nil) {
            exercises.append(exercise!)
            saveExercises()
            timer.invalidate()
            if let saveTime = loadTime(){
                exercisetime = saveTime
                let real = (time2 - totimes) * time1 + time1 - left
                exercisetime += real
                saveTimes()
            }
            else {
                exercisetime = 0
                let real = (time2 - totimes) * time1 + time1 - left
                exercisetime += real
                saveTimes()
            }
        }
    }
    
    @IBAction func startClicked(_ sender: UIButton) {
        //left = 30
        //btn.setTitle("重新开始计时(\(leftTime))", for: .disabled)
        btn.setTitle("暂停", for: .normal)
        self.btn.isEnabled = false
        //获取该计时器的剩余时间
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
    }
   /* func startClicked() {
        
        left = 60
        //btn.setTitle("重新开始计时(\(leftTime))", for: .disabled)
        btn.setTitle("暂停", for: .normal)
        self.btn.isEnabled = false
        //获取该计时器的剩余时间
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
    }*/
    
    func tickDown() {
        //将剩余时间减少1秒
        
        left -= 1
        print(left)
        //修改UIDatePicker的剩余时间
        //btn.setTitle("重新开始计时(\(left))", for: .disabled)
        LeftTime.text = String(left)
        //如果剩余时间小于等于0
        if left <= 0 {
            totimes -= 1
            if(totimes < 0) {
            //取消定时器
                timer.invalidate()
                self.btn.isEnabled = true
                btn.setTitle("开始", for: .normal)
                let alter = UIAlertView()
                alter.title = "时间到"
                alter.message = "时间到"
                alter.addButton(withTitle: "确定")
                alter.show()
            }
            else {
                loop.text = "还剩\(totimes)次循环"
                left = 5
                timer.invalidate()
                timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
            }
        }
    }
    
    //MARK: Private Methods
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Exercise.HistroyArchiverURL.path)) as? [Exercise]
    }
    
    private func loadTime() -> Int? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Information.XArchiverURL.path)) as? Int
    }
    
    private func saveExercises(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(exercises, toFile: (Exercise.HistroyArchiverURL.path))
        if isSuccessfulSave {
            os_log("Exerciseshistory successfully saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save exercises.", log: OSLog.default, type: .error)
        }
    }
    
    private func saveTimes(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(exercisetime, toFile: (Information.XArchiverURL.path))
        if isSuccessfulSave {
            os_log("Exerciseshistory successfully saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save exercises.", log: OSLog.default, type: .error)
        }
    }

}
