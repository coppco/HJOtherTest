//
//  ViewController.swift
//  4.1__Shopping
//
//  Created by M-coppco on 16/6/19.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

//遵循协议
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewItemViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!

    var buyItems = [
        HJItem.init(itemName: "牛奶", itemBrand: "三元"),
        HJItem(itemName: "红烧牛肉面", itemBrand: "康师傅"),
        HJItem(itemName: "桃汁", itemBrand: "汇源"),
        HJItem(itemName: "巧克力", itemBrand: "德芙"),
        HJItem(itemName: "地板净", itemBrand: "滴露"),
        HJItem(itemName: "洗发水", itemBrand: "飘柔")
    ]
    /*
    let buyItems = [("牛奶", "三元"),
        ("红烧牛肉面", "康师傅"),
        ("桃汁", "汇源"),
        ("巧克力", "德芙"),
    ("地板净", "滴露"),
        ("洗发水", "飘柔")]
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        //iOS 8需要添加这句
        self.edgesForExtendedLayout = UIRectEdge.None
        //去掉多余分割线
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    //执行segue的时候 前面执行
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showItem" {
            let destinationVC : ItemViewController = segue.destinationViewController as! ItemViewController
            let item = buyItems[sender as! NSInteger]
            destinationVC.item = item
        } else if segue.identifier == "newItem" {
            let destinationVC : NewItemViewController = segue.destinationViewController as! NewItemViewController
            destinationVC.delegate = self
        }
    }
    
    func addNewItem(controller: NewItemViewController, item: HJItem) {
        buyItems.append(item)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = buyItems[indexPath.row]
        cell.textLabel?.text = item.itemName
        cell.detailTextLabel?.text = item.itemBrand
        if item.isBuy {
            cell.textLabel?.textColor = UIColor.greenColor()
        } else {
            cell.textLabel?.textColor = UIColor.redColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let (item, brand) = buyItems[indexPath.row]
        self.performSegueWithIdentifier("showItem", sender: indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
   
}

