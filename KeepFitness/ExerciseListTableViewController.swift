//
//  ExerciseListTableViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/5.
//  Copyright © 2017年 nju. All rights reserved.
//
import os.log
import UIKit

class ExerciseListTableViewController: UITableViewController {

    var exercises = [Exercise]()
    let cellIdentifier = "ExerciseID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        if let saveExercises = loadExercises() {
            exercises += saveExercises
        }
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "StartExercise", sender: self)    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ExerciseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ExerciseTableViewCell
        if (cell == nil){
            cell = ExerciseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let exercise  = exercises[indexPath.row]
        
        cell.Action.text = exercise.Name
        cell.photo.image = exercise.photo
        cell.time.text = exercise.StartTime
        // Configure the cell...
        
        return cell
    }
    
    //MARK: Actions
    public func updateList() {
        if let saveExercises = loadExercises() {
            exercises = saveExercises
        }
        let newIndexpath = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [newIndexpath], with: .none)
        
    }

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //print("yes")
        if segue.identifier == "StartExercise" {
            let controller = segue.destination as! TimeViewController
        }
    }
    

    //MARK: Private Methods
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Exercise.ArchiverURL?.path)!) as? [Exercise]
    }
}
