//
//  ViewController.swift
//  9.1__photos
//
//  Created by M-coppco on 16/6/21.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit
import Photos  //导入框架

let albumName = "photos Gallery"
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var albumFound : Bool = false
    var assetCollection : PHAssetCollection!
    var photoAsset : PHFetchResult!
    
    @IBOutlet weak var collectionV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None //去掉

        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: .Any, options: fetchOptions)
        if collection.firstObject != nil {
            self.albumFound = true
            self.assetCollection = collection.firstObject as! PHAssetCollection
        } else {
            print("照片集:\(albumName) 不存在,现在去创建")
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                }, completionHandler: { (success, error) -> Void in
                    if error != nil {
                        print("创建照片集失败")
                    } else {
                        print("创建照片集成功")
                    }
                    self.albumFound = success
            })
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! PhotoViewController
        let indexPath : NSIndexPath = self.collectionV.indexPathForCell(sender as! UICollectionViewCell)!
        controller.index = indexPath.item
        controller.photoAsset = self.photoAsset
        controller.assetCollection = self.assetCollection
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = true
        self.photoAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        self.collectionV.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func camera(sender: UIBarButtonItem) {
    }

    @IBAction func orginalbum(sender: UIBarButtonItem) {
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoAsset.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : PhotoThumbnail = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoThumbnail
        let asset : PHAsset = self.photoAsset[indexPath.item] as! PHAsset
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil) { (result, info) -> Void in
            cell.setThumbnailImage(result!)
        }
        return cell
    }
    
}

