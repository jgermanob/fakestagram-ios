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
    }
    
    func selectImage(){
        isFirstTime = false
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
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
            
        }
        present(picker, animated: true, completion: nil)
    }
    
    //Function to share a post once an image was selected from image picker
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
