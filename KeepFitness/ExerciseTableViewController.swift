//
//  ExerciseTableViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/4.
//  Copyright © 2017年 nju. All rights reserved.
//

import os.log
import UIKit

class ExerciseTableViewController: UITableViewController {

    //MARK: Properties
    var exercises = [Exercise]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem = editButtonItem
        
        if let saveExercises = loadExercises() {
            exercises += saveExercises
        }
        else {
            loadSampleExercise()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            exercises.remove(at: indexPath.row)
            saveExercises()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Add a new exercise.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let exerciseDetailViewController = segue.destination as? ExerciseViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedExerciseCell = sender as? ExerciseListTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedExerciseCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedExercise = exercises[indexPath.row]
            exerciseDetailViewController.exercise = selectedExercise
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToExerciseList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? ExerciseViewController, let exercise = sourceViewController.exercise {
            //Add a new Exercise
            if let selectedIndexpath = tableView.indexPathForSelectedRow {
                exercises[selectedIndexpath.row] = exercise
                tableView.reloadRows(at: [selectedIndexpath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: exercises.count, section: 0)
                exercises.append(exercise)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveExercises()
        }
    }
    @IBAction func Back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    private func saveExercises(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(exercises, toFile: Exercise.ArchiverURL.path)
        if isSuccessfulSave {
            os_log("Exercises successfully saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save exercises.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Exercise.ArchiverURL.path) as? [Exercise]
    }
    
    private func loadSampleExercise() {
        let photo1 = UIImage(named: "exercise1")
        let photo2 = UIImage(named: "exercise1")
        let photo3 = UIImage(named: "exercise1")
        
        guard let exercise1 = Exercise(Name: "平板支撑", photo: photo1, Action: "work", StartTime: "6:30", EndTime: "7:00") else {
            fatalError("Unable to instantiate exercise1")
        }
        guard let exercise2 = Exercise(Name: "仰卧起坐", photo: photo2, Action: "work", StartTime: "6:30", EndTime: "7:00") else {
            fatalError("Unable to instantiate exercise2")
        }
        guard let exercise3 = Exercise(Name: "引体向上", photo: photo3, Action: "work", StartTime: "6:30", EndTime: "7:00") else {
            fatalError("Unable to instantiate exercise3")
        }
        exercises += [exercise1, exercise2, exercise3]
    }

}
