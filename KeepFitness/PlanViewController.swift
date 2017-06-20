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
    //@IBOutlet weak var running: UIButton!
    @IBOutlet weak var exe: UIButton!
    @IBOutlet weak var hour: UIButton!
    @IBOutlet weak var totaltime: UILabel!
    
    
    var exercises = [Exercise]()
    let cellIdentifier = "ExerciseID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ExerciseCell!.delegate = self
        self.ExerciseCell!.dataSource = self
        
        //running.layer.cornerRadius = 15.0
        //running.layer.borderWidth = 1.0
        
        exe.layer.cornerRadius = 15.0
        exe.layer.borderWidth = 1.0
        
        hour.layer.cornerRadius = 15.0
        hour.layer.borderWidth = 1.0
        
        clickView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction))
        
        clickView.addGestureRecognizer(tapGesture)
        //let tap = UITapGestureRecognizer(target: self, action: Selector(("tapClick")))
        //self.clickView.isUserInteractionEnabled = true
        //self.clickView.addGestureRecognizer(tap)
        
        //self.LoadExercise!.delegate = self
        //self.LoadExercise!.dataSource = self
        self.ExerciseCell.register(UINib(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        //self.LoadExercise.register(UINib(nibName: "DetailTableViewCell"), bundle: nil), forCellReuseIdentifier: "
        if let saveExercises = loadExercises() {
            if(saveExercises.count == 0) {
                loadSample()
            
            }
            else{
                exercises += saveExercises
            }
    
        }
        else {
            loadSample()
        }
        if let saveTime = loadTime() {
            totaltime.text = String(saveTime / 60)
        }
        else {
            totaltime.text = "0"
        }
        
    }
    
    func tapGestureAction() {
        self.performSegue(withIdentifier: "Show", sender: nil)
        print("yes")
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
        if let selectedIndexpath = tableView.indexPathForSelectedRow {
            print("choose\(selectedIndexpath.row)")
        }
        else {
            print("choose\(indexPath.row)")
        }
        self.performSegue(withIdentifier: "StartExercise", sender: indexPath)
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
        if exercises.count == 0{
            loadSample()
        }
        if let saveTime = loadTime() {
            totaltime.text = String(saveTime / 60)
        }
        else {
            totaltime.text = "0"
        }
    }
    
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Exercise.ArchiverURL.path)) as? [Exercise]
    }
    
    private func loadTime() -> Int? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Information.XArchiverURL.path)) as? Int
    }
    
    private func loadSample(){
        let photo = UIImage(named: "keep")
        let photo1 = UIImage(named: "go")
        
        guard let exercise1 = Exercise(Name: "分段跑强化燃脂", photo: photo, Action: "分段跑", StartTime: " ", EndTime: " ") else {
            fatalError("Unable to instantiate exercise1")
        }
        guard let exercise2 = Exercise(Name: "初学者必备", photo: photo1, Action: "慢跑", StartTime: "", EndTime: "") else {
            fatalError("Unable to instantiate exercise1")
        }
        print("load successful")
        exercises += [exercise2, exercise1]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "StartExercise" {
            let controller = segue.destination as! TimeViewController
            guard let indexPath = sender else {
                fatalError("The selected cell is not being displayed by the table")
            }
            print((indexPath as AnyObject).row)
            
            let selectedExercise = exercises[(indexPath as AnyObject).row]
            if(selectedExercise == nil){
                print("nil")
            }
            controller.exercise = selectedExercise
            
        }
        else if segue.identifier == "Show" {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! ExerciseListTableViewController
            //controller.title = sender as? String
        }
        else if segue.identifier == "Time" {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! HourTableViewController
            print("计时器")
            controller.title = "计时器"
        }
    }
    
    
}

