//
//  CameraViewController.swift
//  fakestagram
//
//  Created by LuisE on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import YPImagePicker

class CameraViewController: UIViewController, UINavigationControllerDelegate {
    let client = CreatePostClient()
    
    override func viewWillAppear(_ animated: Bool) {
        //mamalonImagePicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mamalonImagePicker()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTapSnap(_ sender: Any) {
       /* guard let img = UIImage(named: "drake"),
              let imgBase64 = img.encodedBase64() else { return }
        let payload = CreatePostBase64(title: "Yaaas! - \(Date().currentTimestamp())",
            imageData: imgBase64)
        client.create(payload: payload) { post in
            print(post)
        }*/
        
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func mamalonImagePicker(){
        var config = YPImagePickerConfiguration()
        config.usesFrontCamera = true
        YPImagePickerConfiguration.shared = config
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto{
                print(photo.fromCamera)
                print(photo.image)
                print(photo.originalImage)
                print(photo.modifiedImage)
                print(photo.exifMeta)
            }
            //picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
}

//Extension to upload a post with selected image
extension CameraViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage, let imageBase64 = image.encodedBase64() else {return}
        let payload = CreatePostBase64(title: "Image selected from gallery \(Date().currentTimestamp())", imageData: imageBase64)
        client.create(payload: payload) { post in
            print(post)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
