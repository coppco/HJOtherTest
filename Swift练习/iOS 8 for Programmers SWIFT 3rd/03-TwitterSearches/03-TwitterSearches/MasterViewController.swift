//
//  MasterViewController.swift
//  03-TwitterSearches
//
//  Created by coco on 16/4/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, ModelDelegate, UIGestureRecognizerDelegate {

    var detailViewController: DetailViewController? = nil
    let twitterSearchURL = "http://mobile.twitter.com/search/?q="
    var model : Model!
    func modelDataChanged() {
        tableView.reloadData()
    }
    
    
    var objects = [AnyObject]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSizeMake(320, 600)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonPressed:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        model = Model(delegate: self)  //初始化
        model.synchronize()
    }
    
    func addButtonPressed(sender : AnyObject) {
        displayAddEditSearchAlert(true, index : nil)
    }

    //长按
    func tableViewCellLongPressed(sender : UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began && !tableView.editing {
            let  cell = sender.view as! UITableViewCell
            if let indexPath = tableView.indexPathForCell(cell) {
                displayLongPressedOptions(indexPath.row)
            }
        }
    }
    
    func displayLongPressedOptions(row : Int) {
        let alertController = UIAlertController(title: "Options", message: "Edit or Share your search", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let editAction = UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: {(action) in self.displayAddEditSearchAlert(true, index : row)})
        alertController.addAction(editAction)
        
        let shareAction = UIAlertAction(title: "Share", style: UIAlertActionStyle.Default, handler: {(action) in self.shareSearch(row)})
        alertController.addAction(shareAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func displayAddEditSearchAlert(isNew : Bool, index : Int?) {
        let alertController = UIAlertController(
            title: isNew ? "Add Search" : "Edit Search",
            message: isNew ? "" : "Modify your query",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler ({ (textField) in
            if isNew {
                textField.placeholder = "Enter Twitter search query"
            } else {
                textField.text = self.model.queryForIndex(index!)
            }
        })
        
        alertController.addTextFieldWithConfigurationHandler ({ (textField) in
            if isNew {
                textField.placeholder = "Tag your query"
            } else {
                textField.text = self.model.tagAtIndex(index!)
                textField.enabled = false
                textField.textColor = UIColor.lightGrayColor()
            }
        })
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { (action) in
            let query = ((alertController.textFields![0]) as UITextField).text
            let tag = ((alertController.textFields![1]) as UITextField).text
            
            if !(query?.isEmpty)! && !(tag?.isEmpty)! {
                self.model.saveQuery(query: query!, forTag: tag!, syncToCloud: true)
                
                if isNew {
                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
        })
        alertController.addAction(saveAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //分享
    func shareSearch(row : Int) {
        let message = "Check out the results of this Twitter search"
        let urlString = twitterSearchURL + urlEncodeString(model.queryForIndex(row))
        let itemsToShare = [message, urlString]
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    //地址转码
    func urlEncodeString(string : String) -> String {
        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                let query = String(model.queryForIndex(indexPath.row))
                
                
                controller.detailItem = NSURL(string: twitterSearchURL + urlEncodeString(query))
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

//        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = model.tagAtIndex(indexPath.row)
        let longPress = UILongPressGestureRecognizer(target: self, action: "tableViewCellLongPressed:")
        longPress.minimumPressDuration = 0.5
        cell .addGestureRecognizer(longPress)
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
            
            model.deleteSearchAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        model.moveTagAtIndex(sourceIndexPath.row, toDestinationIndex: destinationIndexPath.row)
    }
}

