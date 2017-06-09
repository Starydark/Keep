//
//  InfoViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/7.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableData = ["昵称", "简介", "年龄", "性别", "身高", "体重"]
    
    //MARK: Properties
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var TableCell: UITableView!
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Image.layer.cornerRadius = self.Image.bounds.height / 2
        self.TableCell!.delegate = self
        self.TableCell!.dataSource = self
        self.TableCell.register(UINib(nibName: "DetailTableViewCell", bundle:nil),forCellReuseIdentifier:"DetailID")
        //self.Image.contentMode = UIViewContentMode.center
        // Do any additional setup after loading the view.
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
        tableView.deselectRow(at: indexPath, animated: true)
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
        cell.Icon.image = UIImage(named: "next")
        return cell
    }

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
