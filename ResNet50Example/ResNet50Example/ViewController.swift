//
//  ViewController.swift
//  ResNet50Example
//
//  Created by Lucas A. dos Santos on 12/03/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var resnetModel = Resnet50()
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        imagePicker.delegate = self
        if let image = imageView.image {
            classifyPicture(image: image)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func classifyPicture(image: UIImage){
        if let model = try? VNCoreMLModel(for: resnetModel.model) {
            let request = VNCoreMLRequest(model: model) {
                (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    let result = results[0]
                    self.resultLabel.text = result.identifier
                }
            }
            
            if let imageData = image.jpegData(compressionQuality: 1.0){
                let handler = VNImageRequestHandler(data: imageData, options: [:])
                try? handler.perform([request])
            }
        }
        
    }

    @IBAction func albumTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            classifyPicture(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

