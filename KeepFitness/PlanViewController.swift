//
//  PlanViewController.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/5.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    //@IBOutlet weak var contain: UIView!
    @IBOutlet weak var ExerciseCell: UITableView!
    //@IBOutlet weak var clickView: ClickView!
   //  @IBOutlet weak var LoadExercise: UITableView!
    @IBOutlet weak var clickView: UIView!
    
    
    var exercises = [Exercise]()
    let cellIdentifier = "ExerciseID"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ExerciseCell!.delegate = self
        self.ExerciseCell!.dataSource = self
        
        //let tap = UITapGestureRecognizer(target: self, action: Selector(("tapClick")))
        //self.clickView.isUserInteractionEnabled = true
        //self.clickView.addGestureRecognizer(tap)
        
        //self.LoadExercise!.delegate = self
        //self.LoadExercise!.dataSource = self
        self.ExerciseCell.register(UINib(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        //self.LoadExercise.register(UINib(nibName: "DetailTableViewCell"), bundle: nil), forCellReuseIdentifier: "
        if let saveExercises = loadExercises() {
            exercises = saveExercises
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Show", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:ExerciseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ExerciseTableViewCell
        if (cell == nil){
            cell = ExerciseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        if indexPath.row < exercises.count {
            let exercise  = exercises[indexPath.row]
        
            cell.Action.text = exercise.Name
            cell.photo.image = exercise.photo
            cell.time.text = exercise.StartTime
            // Configure the cell...
        }
        else {
            cell.Action.text = ""
            cell.time.text = ""
            cell.photo.image = UIImage(named: "exercise1")
        }
        return cell
    }
    /*
    //tap
    func tapClick(sender: UIView){
        print("beidianji")
    }
    */
    //MARK: Action
    
    @IBAction func unwindExerciseList(sender: UIStoryboardSegue){
        let exerciseController = ExerciseListTableViewController()
        if let saveExercises = loadExercises() {
            exercises = saveExercises
        }
        self.ExerciseCell.reloadData()
       
    }
    
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Exercise.ArchiverURL?.path)!) as? [Exercise]
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //super.prepare(for: segue, sender: sender)
        if segue.identifier == "Show"{
            let controller = segue.destination as! TimeViewController
        }
    }
    
}
