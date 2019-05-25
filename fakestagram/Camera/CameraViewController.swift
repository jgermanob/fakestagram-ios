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
    @IBOutlet weak var postPreview: UIImageView!
    @IBOutlet weak var postCaption: UITextField!
    var isFirstTime = true
    
    override func viewDidAppear(_ animated: Bool) {
        if isFirstTime{
            selectImage()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        /*let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            }
            self.dismiss(animated: true, completion: nil)
            /*self.dismiss(animated: true, completion: {
                print("self.dismiss()")
                picker.dismiss(animated: true, completion: nil)
            })*/
            //picker.dismiss(animated: true, completion: nil)
            self.tabBarController?.selectedIndex = 0
            
        }
        present(picker, animated: true, completion: nil)*/
        
    }
    
    func selectImage(){
        isFirstTime = false
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                self.postPreview.image = photo.image
            }
            
            if self.postPreview.image == nil{
                self.dismiss(animated: true, completion: nil)
                self.tabBarController?.selectedIndex = 0
                self.isFirstTime = true
            }else{
                self.isFirstTime = false
                picker.dismiss(animated: true, completion: nil)
            }
            //self.dismiss(animated: true, completion: nil)
            /*self.dismiss(animated: true, completion: {
             print("self.dismiss()")
             picker.dismiss(animated: true, completion: nil)
             })*/
            //picker.dismiss(animated: true, completion: nil)
            //self.tabBarController?.selectedIndex = 0
            
        }
        present(picker, animated: true, completion: nil)
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
    
    @IBAction func sharePost(_ sender: UIButton) {
        print("Share")
        guard let image = postPreview.image as? UIImage, let imageBase64 = image.encodedBase64() else {return}
        let payload = CreatePostBase64(title: postCaption.text!, imageData: imageBase64)
        client.create(payload: payload) { post in
            print(post)
        }
        tabBarController?.selectedIndex = 0
        postPreview.image = nil
        isFirstTime = true
        
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
