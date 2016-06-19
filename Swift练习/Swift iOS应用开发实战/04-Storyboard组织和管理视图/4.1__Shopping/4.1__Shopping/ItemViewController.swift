//
//  ItemViewController.swift
//  4.1__Shopping
//
//  Created by M-coppco on 16/6/19.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var brandL: UILabel!
    
    var item : HJItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameL.text = item?.itemName
         self.nameL.text = item?.itemBrand
        if item?.isBuy == true {
       self.nameL.textColor = UIColor.greenColor()
        } else {
            self.nameL.textColor = UIColor.redColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //买
    @IBAction func buyTap(sender: UIButton) {
        if item != nil {
            if item?.isBuy == false {
                item?.isBuy = true
                nameL.textColor = UIColor.greenColor()
            } else {
                item?.isBuy = false
                nameL.textColor = UIColor.redColor()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
