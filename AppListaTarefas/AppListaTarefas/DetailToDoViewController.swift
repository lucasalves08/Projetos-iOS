//
//  DetailToDoViewController.swift
//  AppListaTarefas
//
//  Created by Lucas A. dos Santos on 28/02/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit

class DetailToDoViewController: UIViewController {
    var taskCoreData: TaskCoreData? = nil
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = taskCoreData {
            if task.priority == 1 {
                if let name = task.name {
                    nameLabel.text = " ! " + name
                }
                
            }
            else if task.priority == 2 {
                if let name = task.name {
                    nameLabel.text = " !! " + name
                }
            }
            else {
                if let name = task.name {
                    nameLabel.text = name
                }
            }
            if let desc = task.desc {
                descriptionTextView.text = desc
            }
            
            if let data = task.image {
                imageView.image = UIImage(data: data)
            }
            
        }
        


        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let task = taskCoreData {
                context.delete(task)
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
