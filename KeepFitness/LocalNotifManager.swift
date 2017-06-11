//
//  LocalNotifManager.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/10.
//  Copyright © 2017年 nju. All rights reserved.
//

import UserNotifications
import UIKit

class LocalNotifManager: NSObject {
    
    class func getRemindIemeWithString(remindTime: String, afterMinter: Int) -> String {
        let array = remindTime.components(separatedBy: ":")
        if array.count == 2 {
            var hour = Int(array[0])
            var minter = Int(array[1])
            var totalMinter = hour! * 60 + minter!
            totalMinter += afterMinter
            
            hour = Int(totalMinter / 60)
            minter = Int(totalMinter % 60)
            if minter! > 0 {
                return String(hour!) + ":" + String(minter!)
            }
            else {
                return String(hour!) + ":0" + String(minter!)
            }
        }
        return remindTime
    }
    
    override init(){
        
        let lockAction = UNNotificationAction(identifier: "lock_action", title: "点击解锁", options: .authenticationRequired)
        let cancelAction = UNNotificationAction(identifier: "cancel_action", title: "点击消失", options: .destructive)
        let sureAction = UNNotificationAction(identifier: "sure_action", title: "点击进入app", options: .foreground)
        
        //设置一组通知类型，通过local_notification来标识
        let category = UNNotificationCategory(identifier: "local_notification", actions: [sureAction, lockAction, cancelAction], intentIdentifiers: [], options: .customDismissAction)
        
        //将该类型同志加入到通知中心
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func setLocalNotification(with dateString: String, times: Int) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        self.addNotifi(dataString: dateString, sound: UNNotificationSound(named: "Reminder_to_wear_watch.m4a"), index: 0, times: times, week: 0)
    }
    
    func addNotifi(dataString: String, sound: UNNotificationSound, index: Int, times: Int, week: Int){
        if index >= times {
            return
        }
        
        let newDataString = LocalNotifManager.getRemindIemeWithString(remindTime: dataString, afterMinter: index)
        let array = newDataString.components(separatedBy: ":")
        let hour = Int(array[0])
        let minute = Int(array[1])
        var component = DateComponents()
        component.hour = hour
        component.minute = minute
        
        //通知有四种触发器
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: component, repeats: true)
        
        //通知上下文，通过categoryIdentifier来唤醒对应的通知类型
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "local_notification"
        content.title = "通知标题"
        content.body = "通知实体"
        content.sound = sound
        
        //向消息通知注册多条通知时，记得request的identifier 不能用一个，如果设置了多条request， 但是identifier都是一样的，只能触发最晚的那条通知
        let request = UNNotificationRequest(identifier: "request" + dataString + String(index), content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            (error) in print("week:\(component.weekday) hour:\(component.hour) minute:\(component.minute) index: \(index) success")
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.addNotifi(dataString: dataString, sound: sound, index: index + 1, times: times, week: week)
        }
    }
}
