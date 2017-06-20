//
//  HourTableViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/20.
//  Copyright © 2017年 nju. All rights reserved.
//
import os.log
import UIKit

class HourTableViewController: UITableViewController {

    var exercises = [Exercise]()
    let cellIdentifier = "ExerciseID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tableView.register(UINib(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        loadSampleExercise()
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ExerciseListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExerciseListTableViewCell else {
            fatalError("The dequeued cell is not an instance of ExerciseListTableViewCell.")
        }
        
        let exercise  = exercises[indexPath.row]
        
        cell.Action.text = exercise.Name
        cell.photo.image = exercise.photo
        
        cell.time.text = exercise.StartTime
        // Configure the cell...
        
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Start")
        if let selectedIndexpath = tableView.indexPathForSelectedRow {
            print("choose\(selectedIndexpath.row)")
        }
        else {
            print("chse\(indexPath.row)")
        }
        print("Start")
        self.performSegue(withIdentifier: "Start", sender: indexPath)
    }*/

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
        if segue.identifier == "Start" {
            guard let controller = segue.destination as? LeftTimeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCell = sender as? ExerciseListTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedExercise = exercises[indexPath.row]
            controller.exercise = selectedExercise
            controller.title = selectedExercise.Name
            if(indexPath as AnyObject).row == 0 {
                controller.left = 30
                controller.totimes = 10
            }
            else if (indexPath as AnyObject).row == 1 {
                controller.left = 30
                controller.totimes = 15
            }
            else {
                controller.left = 15
                controller.totimes = 5
            }
            controller.exercise = selectedExercise
        }
    }
 
    
    //MARK: Private
    private func loadSampleExercise() {
        let photo1 = UIImage(named: "go")
        let photo2 = UIImage(named: "run")
        let photo3 = UIImage(named: "run")
        
        //let size = CGSize(width: 30, height: 30)
        //photo1?.resizableImage(withCapInsets: size)
        //photo1?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: UIImageResizingMode.stretch)
        guard let exercise1 = Exercise(Name: "快走二十分钟", photo: photo1, Action: "30秒倒计时，10个循环", StartTime: "30秒倒计时，10个循环", EndTime: "7:00") else {
            fatalError("Unable to instantiate exercise1")
        }
        guard let exercise2 = Exercise(Name: "变速跑二十分钟", photo: photo2, Action: "15秒倒计时，5个循环", StartTime: "30秒倒计时，10个循环", EndTime: "7:00") else {
            fatalError("Unable to instantiate exercise2")
        }
        guard let exercise3 = Exercise(Name: "高强间歇四分钟", photo: photo3, Action: "15秒倒计时，5个循环", StartTime: "15秒倒计时，5个循环", EndTime: "7:00") else {
            fatalError("Unable to instantiate exercise3")
        }
        exercises += [exercise1, exercise2, exercise3]
    }

}
