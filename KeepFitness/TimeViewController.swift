//
//  TimeViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit
import os.log
import CoreLocation

class TimeViewController: UIViewController, CLLocationManagerDelegate{

    //MARK:Properties
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var stopButton: CustomButton!
    @IBOutlet weak var resetButton: CustomButton!
    
    var exercises = [Exercise]()
    var exercise: Exercise?
    var exercisetime = 0
    
    var isPlaying = false
    var isStop = false
    var zeroTime = TimeInterval()
    var stopTime = TimeInterval()
    var startTime = TimeInterval()
    var endTime = TimeInterval()
    var hasStart = false
    
    var timer: Timer = Timer()
    
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distanceTraveled = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        locationManager.requestWhenInUseAuthorization()
        
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        else {
            print("Location service disable")
        }
        
        startTime = Date.timeIntervalSinceReferenceDate
        endTime = Date.timeIntervalSinceReferenceDate
        
        if let saveExercises = loadExercises() {
            exercises += saveExercises
        }
        
        if let savetime = loadTime() {
            exercisetime = savetime
        }
        else {
            exercisetime = 0
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let date = Date(timeIntervalSinceReferenceDate: startTime)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let st = dformatter.string(from: date)
        //st.substring(from: 10)
        exercise?.StartTime = st
        print(st)
        if(isPlaying){
            endTime = Date.timeIntervalSinceReferenceDate
            if(exercise == nil) {
                print("nil")
            }
            let date1 = Date(timeIntervalSinceReferenceDate: endTime)
            let et = dformatter.string(from: date1)
            exercise?.EndTime = et
            exercises.append(exercise!)
            
            let totalTime = endTime - startTime
            exercisetime += Int(totalTime)
            saveTimes()
            saveExercises()
        }
        else if (hasStart) {
            if(self.exercise == nil) {
                print("nil")
            }
            let date1 = Date(timeIntervalSinceReferenceDate: endTime)
            let et = dformatter.string(from: date1)
            exercise?.EndTime = et
            exercises.append(exercise!)
            saveExercises()
            let totalTime = endTime - startTime
            exercisetime += Int(totalTime)
            saveTimes()
            
        }
        //exercise?.EndTime = stopTime
        //print("true")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Actions
    @IBAction func startTimer(_ sender: UIButton) {
        if isPlaying{
            return
        }
        startButton.isEnabled = false
        stopButton.isEnabled = true
        hasStart = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimeViewController.updateTime), userInfo: nil, repeats: true)
        
        if(!self.isStop) {
            print(isStop)
            zeroTime = Date.timeIntervalSinceReferenceDate
        }
        else if self.isStop{
            print(isStop)
            let currentTime = Date.timeIntervalSinceReferenceDate
            zeroTime = currentTime - stopTime + zeroTime
        }
        isPlaying = true
        isStop = false
        locationManager.startUpdatingLocation()
        
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        timer.invalidate()
        locationManager.stopUpdatingLocation()
        
        isPlaying = false
        isStop = true
        
        stopTime = Date.timeIntervalSinceReferenceDate
        endTime = Date.timeIntervalSinceReferenceDate
        startButton.setTitle("继续", for: .normal)
    }
    
    @IBAction func Reset(_ sender: UIButton) {
        isPlaying = false
        isStop = false
        print(self.isStop)
        distanceTraveled = 0.0
        startLocation = nil
        lastLocation = nil
        startButton.isEnabled = true
        stopButton.isEnabled = false
        endTime = Date.timeIntervalSinceReferenceDate
        
        timer.invalidate()
        
        let strMinutes = String(format: "%02d", 0.0)
        let strSeconds = String(format: "%02d", 0.0)
        let strMSX10 = String(format: "%02d", 0.0)
        
        startButton.setTitle("开始", for: .normal)
        //print("xiugai")
        timerLabel.text = "\(strMinutes):\(strSeconds):\(strMSX10)"
    }
    
    func updateTime() {
       //print(isStop)
       
            let currentTime = Date.timeIntervalSinceReferenceDate
            var timePassed: TimeInterval = currentTime - zeroTime
            let minutes = UInt8(timePassed / 60.0)
            timePassed -= (TimeInterval(minutes) * 60)
            let seconds = UInt8(timePassed)
            timePassed -= TimeInterval(seconds)
            let millisecsX10 = UInt8(timePassed * 100)
            
            let strMinutes = String(format: "%02d", minutes)
            let strSeconds = String(format: "%02d", seconds)
            let strMSX10 = String(format: "%02d", millisecsX10)
        
            timerLabel.text = "\(strMinutes):\(strSeconds):\(strMSX10)"
       
        if timerLabel.text == "60:00:00" {
            timer.invalidate()
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first as CLLocation!
        } else {
            let lastDistance = lastLocation.distance(from: locations.last as CLLocation!)
            distanceTraveled += lastDistance * 0.000621371
            
            let trimmedDistance = String(format: "%.2f", distanceTraveled)
            
            milesLabel.text = "\(trimmedDistance) Miles"
        }
        
        lastLocation = locations.last as CLLocation!
    }
    
    //MARK: Private Methods
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Exercise.HistroyArchiverURL.path)) as? [Exercise]
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
    
    private func loadTime() -> Int? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Information.XArchiverURL.path)) as? Int
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
