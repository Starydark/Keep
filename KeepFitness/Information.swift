//
//  Infomation.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 nju. All rights reserved.
//

import os.log
import UIKit

class Information: NSObject, NSCoding {
    //MARK: Properties
 
    var nickName: String
    var intro: String?
    var age: String?
    var sex: String?
    var height: String?
    var weight: String?
 
    static let filePath: String = NSHomeDirectory() + "/" + LoginViewController().LoginId
    static let URL = NSURL(string: filePath)
    static let ArchiverURL = URL?.appendingPathComponent("information")
    
    
    struct Propertykey {
        static let nickName = "nickName"
        static let intro = "intro"
        static let age = "age"
        static let sex = "sex"
        static let height = "height"
        static let weight = "weight"
    }
    
    //MARK: Initialization
    init?(nickNmae: String, intro: String?, age: String?, sex: String?, height: String?, weight: String?){
        guard !nickNmae.isEmpty else{
            return nil
        }
        self.nickName = nickNmae
        self.intro = intro
        self.age = age
        self.sex = sex
        self.height = height
        self.weight = weight
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nickName, forKey: Propertykey.nickName)
        aCoder.encode(intro, forKey: Propertykey.intro)
        aCoder.encode(age, forKey: Propertykey.age)
        aCoder.encode(sex, forKey: Propertykey.sex)
        aCoder.encode(height, forKey: Propertykey.height)
        aCoder.encode(weight, forKey: Propertykey.weight)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let nickName = aDecoder.decodeObject(forKey: Propertykey.nickName) as? String else {
            os_log("Unable to decode the name for Info object.", log: OSLog.default, type: .debug)
            return nil
        }
        let intro = aDecoder.decodeObject(forKey: Propertykey.intro) as? String
        let age = aDecoder.decodeObject(forKey: Propertykey.age) as? String
        let sex = aDecoder.decodeObject(forKey: Propertykey.sex) as? String
        let height = aDecoder.decodeObject(forKey: Propertykey.height) as? String
        let weight = aDecoder.decodeObject(forKey: Propertykey.weight) as? String
        
        self.init(nickNmae: nickName, intro: intro, age: age, sex: sex, height: height, weight: weight)
    }
}

