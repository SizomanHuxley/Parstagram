//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Michelob Revol on 9/30/22.
//

import UIKit
import AlamofireImage
import Parse


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        //create a new table on parse
        
        let post = PFObject(className: "posts") //table namw
        
        post["caption"] = commentField.text
        post["owner"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData() //change image to an png image
        let file = PFFileObject(name: "image.png", data: imageData!)
       //let file = PFFileObject(data: imageData!) //store image
                               
        
        post["image"] = file
        
        post.saveInBackground {(success, error) in
            if success{
                
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }
            else
            {
                print("erro!")
            }
        }
    }
    
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //picker.sourceType = .camera
            picker.sourceType = .photoLibrary
        }
        else
        {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
        
    }
    
}
