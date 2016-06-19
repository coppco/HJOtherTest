//
//  NewItemViewController.swift
//  4.1__Shopping
//
//  Created by M-coppco on 16/6/19.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

//协议
protocol NewItemViewControllerDelegate {
    func addNewItem(controller: NewItemViewController,item: HJItem)
}

class NewItemViewController: UIViewController {
    @IBOutlet weak var nameL: UITextField!

    @IBOutlet weak var brandL: UITextField!
    var delegate : NewItemViewControllerDelegate! = nil
    
    //public class func animateWithDuration(duration: NSTimeInterval, animations: () -> Void)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameL.becomeFirstResponder()
//        UIView.animateWithDuration(0.1, animations: <#T##() -> Void#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    @IBAction func save(sender: UIButton) {
        if nameL.text != nil && brandL.text != nil {
            let item : HJItem = HJItem(itemName: nameL.text!, itemBrand: brandL.text!)
            delegate.addNewItem(self, item: item)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancel(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
