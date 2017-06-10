//
//  InfoViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/7.
//  Copyright © 2017年 nju. All rights reserved.
//

import os.log
import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableData = ["昵称", "简介", "年龄", "性别", "身高", "体重"]
    
    //MARK: Properties
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var TableCell: UITableView!
    var index: Int = 0
    var info: Information?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Image.layer.cornerRadius = self.Image.bounds.height / 2
        self.TableCell!.delegate = self
        self.TableCell!.dataSource = self
        self.TableCell.register(UINib(nibName: "DetailTableViewCell", bundle:nil),forCellReuseIdentifier:"DetailID")
        
        if let saveinfo = loadInfo() {
            print("loadSuccessful")
            info = saveinfo
        }
        else {
            print("inital")
            InitInfo()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        index = indexPath.row
        let cell:DetailTableViewCell! = tableView.cellForRow(at: indexPath) as! DetailTableViewCell
        self.performSegue(withIdentifier: "ShowDetail", sender: cell.CellValue.text)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailID") as! DetailTableViewCell
        if (cell == nil){
            cell = DetailTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "DetailID")
        }
        cell.CellName.text = tableData[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.CellValue.text = info?.nickName
        case 1:
            cell.CellValue.text = info?.intro
        case 2:
            cell.CellValue.text = info?.age
        case 3:
            cell.CellValue.text = info?.sex
        case 4:
            cell.CellValue.text = info?.height
        case 5:
            cell.CellValue.text = info?.weight
        default:
            fatalError("Unspcted row at \(indexPath.row)")
        }
        print("result: \(indexPath.row) at \(cell.CellValue.text)")
        cell.Icon.image = UIImage(named: "next")
        return cell
    }

    
    //MARK: Actions
    //MARK: Navigation
    
    /*@IBAction func cancle(_ sender: UIBarButtonItem) {
        let isPresentingInInfo = presentingViewController is UINavigationController
        if isPresentingInInfo {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The infoViewController is not inside a navigation controller.")
        }
    }*/
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowDetail" {
            //print("yes")
            let nav = segue.destination as! UINavigationController
            guard let controller = nav.topViewController as? DetailViewController else {
                fatalError("Unexpected destination: \(sender)")
            }
            //print(index)
            controller.titleName = tableData[index]
            controller.titleValue = (sender as? String)!
        }
    }
    
    @IBAction func unwindToInfoList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? DetailViewController, let infomation = sourceViewController.changeValue {
            if let selectIndexPath = TableCell.indexPathForSelectedRow {
                switch selectIndexPath.row {
                case 0:
                    info?.nickName = infomation
                case 1:
                    info?.intro = infomation
                case 2:
                    info?.age = infomation
                case 3:
                    info?.sex = infomation
                case 4:
                    info?.height = infomation
                case 5:
                    info?.weight = infomation
                default:
                    break;
                }
                TableCell.reloadData()
            }
            else {
                fatalError("Unsepcted nil row")
            }
        }
        saveInfo()
    }
    
    //MARK: Private Methods
    private func saveInfo(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(info, toFile: (Information.ArchiverURL?.path)!)
        if isSuccessfulSave{
            os_log("Information successfully saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Faild to save informations.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadInfo() -> Information? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Information.ArchiverURL?.path)!) as? Information
    }
    
    private func InitInfo(){
        info = Information(nickNmae:  "未设置", intro:  "未设置", age:  "未设置", sex:  "未设置", height:  "未设置", weight:  "未设置")
    }

}
