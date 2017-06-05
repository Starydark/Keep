//
//  PlanViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/5.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController {

    //MARK: Properties
    var exercises = [Exercise]()
    
    //@IBOutlet weak var exercise: ExerciseListTableViewCell!
    //@IBOutlet weak var tableView: UITableView!
    var tableView: UITableView!
    
    let cellIdentifier = "ExerciseListTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let saveExercises = loadExercises() {
            exercises += saveExercises
        }
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //self.tableView!.delegate = self
        //self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseListTableViewCell")
        //self.view.addSubview(tableView)
        
        //exercise.dataso
        /*//创建tableView, 并添加控制器的view
        let tableView = UITableView(frame: view.bounds)
        
        //设置数据源代理
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self as! UITableViewDelegate
        
        //添加到控制器的view
        view.addSubview(tableView)
        
        //注册cell
        tableView.register(ExerciseViewController.self, forCellReuseIdentifier: cellIdentifier)
        */
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ExerciseListTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExerciseListTableViewCell else {
            fatalError("Ther dequeued cell is not an instance of ExerciseListTableViewCell.")
        }
        
        let exercise  = exercises[indexPath.row]
        
        cell.Action.text = exercise.Name
        cell.photo.image = exercise.photo
        cell.time.text = exercise.StartTime
        // Configure the cell...
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            exercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Exercise.ArchiverURL.path) as? [Exercise]
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
