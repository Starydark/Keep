//
//  PersonViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/7.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableData1 = [["title":"个人信息","image":"Username"]]
    var tableData2 = [["title":"运动历史","image":"history"],
                     ["title":"运动总长","image":"total"],
                     ["title":"我的勋章","image":"list"]]
    
    var tableView:UITableView?
    
    var button:UIButton?

    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        self.tableView = UITableView(frame: UIScreen.main.applicationFrame,
                                     style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //self.tableView?.frame = CGRect(x: 0, y: 0, width: 400, height: 380)
        //设置表格背景色
        self.tableView!.backgroundColor = UIColor(red: 0xf0/255, green: 0xf0/255,
                                                  blue: 0xf0/255, alpha: 1)
        //去除单元格分隔线
        //self.tableView!.separatorStyle = .none
        
        //创建一个重用的单元格
        self.tableView!.register(UINib(nibName:"InfoTableViewCell", bundle:nil),
                                    forCellReuseIdentifier:"InfoListID")
        
        self.view.addSubview(self.tableView!)
        button = UIButton(type: .system)
        button?.frame = CGRect(x: 0, y: 380, width: 320, height: 40)
        button?.setTitle("退出登录", for: .normal)
        button?.backgroundColor = UIColor.red
        button?.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
        self.tableView?.addSubview(button!)
    }
    
    func tapped() {
        //print("tapped")
        self.performSegue(withIdentifier: "Logout", sender: self)
    }
    
    @IBAction func Logout(sender: AnyObject){
        
    }
    
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tableData1.count
        case 1:
            return tableData2.count
        default:
            return 0
        }
    }
    
    //单元格高度
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)
        -> CGFloat {
            return 70
    }
    
    //section之间空隙设置
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    //tableView代理：点击一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell:InfoTableViewCell! = tableView.cellForRow(at: indexPath) as! InfoTableViewCell
        print(cell.cellName.text)
        if cell!.cellName.text == "个人信息" {
            self.performSegue(withIdentifier: "ShowInfo", sender: cell.cellName.text)
        }
        else if cell.cellName.text == "运动历史" {
            self.performSegue(withIdentifier: "ShowTable", sender: cell.cellName.text)
        }
        else if cell.cellName.text == "运动总长" {
            self.performSegue(withIdentifier: "ShowTotal", sender: cell.cellName.text)
        }
        else if cell.cellName.text == "我的勋章" {
            self.performSegue(withIdentifier: "ShowHonor", sender: cell.cellName.text)
        }
        //self.navigationController?.pushViewController(viewCtl, animated: true)
        
    }
    //MARK: Actions
    //MARK: Navigation
    
    @IBAction func unwindToPeronView(sender: UIStoryboardSegue){
        
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        var cell:InfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InfoListID") as! InfoTableViewCell
        if (cell == nil){
            cell = InfoTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "infoListID")
        }
        switch (indexPath.section) {
        case 0:
            print("section0\(indexPath.row)")
            let item = tableData1[indexPath.row]
            cell.cellName.text = item["title"]
            cell.cellImg.image = UIImage(named:item["image"]!)
            cell.cellIcon.image = UIImage(named: "next")
        case 1:
            print("section1\(indexPath.row)")
            let item = tableData2[indexPath.row]
            cell.cellName.text = item["title"]
            cell.cellImg.image = UIImage(named:item["image"]!)
            cell.cellIcon.image = UIImage(named: "next")
        default:
            print("no")
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowInfo" {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! InfoViewController
            controller.title = sender as? String
        }
        else if segue.identifier == "ShowTable" {
            let controller = segue.destination as! HistoryTableViewController
            controller.title = sender as? String
        }
        else if segue.identifier == "ShowTotal"{
            let controller = segue.destination as! TotalTimeViewController
            controller.title = sender as? String
        }
        else if segue.identifier == "ShowHonor"{
            let controller = segue.destination as! HonorViewController
            controller.title = sender as? String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
