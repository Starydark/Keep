//
//  TimeViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit
import CoreLocation

class TimeViewController: UIViewController, CLLocationManagerDelegate{

    //MARK:Properties
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var stopButton: CustomButton!
    @IBOutlet weak var resetButton: CustomButton!
    
    
    var isPlaying = false
    var zeroTime = TimeInterval()
    var timer: Timer = Timer()
    
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distanceTraveled = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        else {
            print("Location service disable")
        }
        // Do any additional setup after loading the view.
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
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimeViewController.updateTime), userInfo: nil, repeats: true)
        zeroTime = Date.timeIntervalSinceReferenceDate
        
        locationManager.startUpdatingLocation()
        isPlaying = true
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        timer.invalidate()
        locationManager.stopUpdatingLocation()
        isPlaying = false
    }
    
    @IBAction func Reset(_ sender: UIButton) {
        distanceTraveled = 0.0
        startLocation = nil
        lastLocation = nil
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        
        let strMinutes = String(format: "%02d", 0.0)
        let strSeconds = String(format: "%02d", 0.0)
        let strMSX10 = String(format: "%02d", 0.0)
        
        timerLabel.text = "\(strMinutes):\(strSeconds):\(strMSX10)"
    }
    
    func updateTime() {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
