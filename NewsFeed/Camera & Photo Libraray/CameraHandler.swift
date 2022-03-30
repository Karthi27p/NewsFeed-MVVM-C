//
//  CameraHandler.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 28/03/22.
//

import Foundation
import UIKit

class CameraHandler: NSObject {
    var currentVC: UIViewController?
    var completion: ((UIImage) -> ())?
    
    static var shared = CameraHandler()
    
    func openCamera() {
       if UIImagePickerController.isSourceTypeAvailable(.camera)  {
        let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.sourceType = .camera
           currentVC?.present(imagePicker, animated: true, completion: nil)
       }
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            currentVC?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func showAlert(currentVC: UIViewController) {
        self.currentVC = currentVC
        let alert = UIAlertController(title: "Camera & Photo Libraary", message: nil, preferredStyle: .actionSheet)
        let cameraAlertAction = UIAlertAction(title: "Camera", style: .default, handler: { [self]_ in
            self.openCamera()
        })
        let libraryAlertAction = UIAlertAction(title: "Library", style: .default, handler: { [self]_ in
            self.openPhotoLibrary()
        })
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            currentVC.dismiss(animated: true)
        })
        alert.addAction(cameraAlertAction)
        alert.addAction(libraryAlertAction)
        alert.addAction(cancelAlertAction)
        currentVC.present(alert, animated: true, completion: nil)
    }
}

extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        completion?(image)
        currentVC?.dismiss(animated: true, completion: nil)
    }
}
