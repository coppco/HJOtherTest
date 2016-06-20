//
//  PhotoViewController.swift
//  9.1__photos
//
//  Created by M-coppco on 16/6/21.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit
import Photos
class PhotoViewController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    var assetCollection : PHAssetCollection!   //照片集对象
    var photoAsset : PHFetchResult!  //照片集所有照片的集合
    var index : Int = 0   //照片在照片集中的位置
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func action(sender: UIBarButtonItem) {
    }
    
    @IBAction func trash(sender: UIBarButtonItem) {
    }
}
