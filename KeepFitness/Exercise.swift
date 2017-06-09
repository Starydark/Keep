//
//  Exercise.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/4.
//  Copyright © 2017年 nju. All rights reserved.
//
import os.log
import UIKit

class Exercise: NSObject, NSCoding {
    //MARK: Properties
    
    var Name: String
    var Action: String
    var photo: UIImage?
    var StartTime: String
    var EndTime: String
    
    //static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let filePath: String = NSHomeDirectory() + LoginViewController().LoginId
    
    static let URL = NSURL(string: filePath)
    static let ArchiverURL = URL?.appendingPathComponent("exercises")
    
    struct Propertykey {
        static let Name = "Name"
        static let Action = "Actino"
        static let photo = "photo"
        static let StartTime = "StartTime"
        static let EndTime = "EndTime"
    }
    
    //MARK: Initialization
    init?(Name: String, photo: UIImage?, Action: String, StartTime: String, EndTime: String) {
        guard !Name.isEmpty else {
            return nil
        }
        guard !Action.isEmpty else {
            return nil
        }
        self.Name = Name
        self.photo = photo
        self.Action = Action
        self.StartTime = StartTime
        self.EndTime = EndTime
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: Propertykey.Name)
        aCoder.encode(Action, forKey: Propertykey.Action)
        aCoder.encode(photo, forKey: Propertykey.photo)
        aCoder.encode(StartTime, forKey: Propertykey.StartTime)
        aCoder.encode(EndTime, forKey: Propertykey.EndTime)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let Name = aDecoder.decodeObject(forKey: Propertykey.Name) as? String else {
            os_log("Unable to decode the name for ma Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let Action = aDecoder.decodeObject(forKey: Propertykey.Action) as? String else {
            os_log("Unable to decode the Action for ma Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let StartTime = aDecoder.decodeObject(forKey: Propertykey.StartTime) as? String else {
            os_log("Unable to decode the StartTime for ma Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let EndTime = aDecoder.decodeObject(forKey: Propertykey.EndTime) as? String else {
            os_log("Unable to decode the EndTime for ma Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: Propertykey.photo) as? UIImage
        
        self.init(Name: Name, photo: photo, Action: Action, StartTime: StartTime, EndTime: EndTime)
    }
    
}
