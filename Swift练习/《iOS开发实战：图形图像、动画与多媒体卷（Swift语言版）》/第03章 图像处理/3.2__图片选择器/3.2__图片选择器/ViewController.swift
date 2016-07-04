//
//  ViewController.swift
//  3.2__图片选择器
//
//  Created by coco on 16/7/4.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageV: UIImageView!
    var imagePicker : UIImagePickerController!
    
    @IBAction func photoLibrary(sender: UIButton) {
        self.changePhotoType(.SavedPhotosAlbum)
    }
    
    @IBAction func camera(sender: UIButton) {
        self.changePhotoType(UIImagePickerControllerSourceType.Camera)
    }
    
    func changePhotoType(type:UIImagePickerControllerSourceType) {
        self.imagePicker.sourceType = type
        if UIImagePickerController.isSourceTypeAvailable(type) {
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.imagePicker == nil {
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage]
        if image != nil {
            self.imageV.image = image! as? UIImage
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}

