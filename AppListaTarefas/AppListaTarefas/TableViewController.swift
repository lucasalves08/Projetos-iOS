//
//  TableViewController.swift
//  AppListaTarefas
//
//  Created by Lucas A. dos Santos on 28/02/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
//    var toDos:[ToDO] = []
    var tasksCoreDatas:[TaskCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAllTasks()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksCoreDatas.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectTask = tasksCoreDatas[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectTask)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let cell = UITableViewCell()
        let selectedTask = tasksCoreDatas[indexPath.row]
        
        if selectedTask.priority == 1 {
            if let name = selectedTask.name {
                cell.textLabel?.text = " ❗️ " + name
            }
        }
        else if selectedTask.priority == 2 {
            if let name = selectedTask.name {
                cell.textLabel?.text =  " ‼️ " + name
            }
        }
        else {
            if let name = selectedTask.name {
                cell.textLabel?.text = name
            }
        }
        
        if let data = selectedTask.image {
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addToDoViewController = segue.destination as? AddToDoViewController {
            addToDoViewController.toDoTableViewController = self
        }
        
        if let detailsToDoViewControler = segue.destination as? DetailToDoViewController {
            if let selectedTask = sender as? TaskCoreData {
                detailsToDoViewControler.taskCoreData = selectedTask
            }
        }
        
    }
    
    func getAllTasks(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let tasksFromCoreData = try? context.fetch(TaskCoreData.fetchRequest()) {
                if let tasks = tasksFromCoreData as? [TaskCoreData] {
                    tasksCoreDatas = tasks
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let seletedTask = tasksCoreDatas[indexPath.row]
                context.delete(seletedTask)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getAllTasks()
            }
        } else if editingStyle == .insert {
            // criar metodo dps
        }
        
    }
 

}
