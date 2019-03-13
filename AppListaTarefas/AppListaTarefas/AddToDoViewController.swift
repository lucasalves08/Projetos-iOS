//
//  AddToDoViewController.swift
//  AppListaTarefas
//
//  Created by Lucas A. dos Santos on 28/02/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var toDoTableViewController: TableViewController? = nil
    var status = false
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priotitySegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var pickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        pickerController.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        if validateText(text: nameTextField.text){
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                //Cria um objeto igual ao do banco
                let newTask = TaskCoreData(context: context)
                newTask.priority = Int32(priotitySegmentedControl.selectedSegmentIndex)
                newTask.name = nameTextField.text!
                newTask.desc = descriptionTextField.text!
                // Se o status foi mudado
                if status {
                    newTask.image = imageView.image?.jpegData(compressionQuality: 1.0)
                }
                //Salva no banco
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                //Fecha a tela
                dismiss(animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Oops! ", message: "O Campo nome deve ser preenchido!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            present(alert, animated: true)
        }
        
    }
    
    func validateText(text: String?) -> Bool {
        if text != nil && !text!.isEmpty {
            return true
        }
        return false
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = . camera
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func mediaFolderTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            status = true
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    
    
    

}
