//
//  Model.swift
//  03-TwitterSearches
//
//  Created by coco on 16/4/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
/*协议*/
protocol ModelDelegate {
    func modelDataChanged()
}


class Model: AnyObject {
    private let pairsKey = "TwitterSearchesKVPairs"
    private let tagsKey = "TwitterSearchesKeyOrder"
    
    private var searches : [String:String] = [:]  //字典
    private var tags : [String] = []  //数组
    private var delegate : ModelDelegate? = nil
//    private var name : String?
    
    //初始化
    init(delegate : ModelDelegate) {
        self.delegate = delegate
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let pairs = userDefaults.dictionaryForKey(pairsKey) {
            self.searches = pairs as! [String : String]
        }
        
        if let tagKs = userDefaults.arrayForKey(tagsKey) {
            self.tags = tagKs as! [String]
        }
        //iCloud 变化的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateSearches", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: NSUbiquitousKeyValueStore.defaultStore())
    }
    func synchronize() {
        NSUbiquitousKeyValueStore.defaultStore().synchronize()
    }
    
    /**
     通知执行方法
     */
    @objc func updateSearches(notification : NSNotification) {
        if let userInfo = notification.userInfo {
            if let reason = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as! NSNumber? {
                if reason.integerValue == NSUbiquitousKeyValueStoreServerChange || reason.integerValue == NSUbiquitousKeyValueStoreInitialSyncChange {
                    performUpdates(userInfo)
                }
            }
        }
    }
    func performUpdates(userInfo : [NSObject : AnyObject?]) {
        let changedKeysObject = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey]
        let changeKeys = changedKeysObject as! [String]
        let keyValueStore = NSUbiquitousKeyValueStore.defaultStore()
        
        for key in changeKeys {
            if let query = keyValueStore.stringForKey(key) {
                saveQuery(query: query, forTag : key, syncToCloud : false)
            } else {
                searches.removeValueForKey(key)
                tags = tags.filter{$0 != key}
                updateUserDefault(true, updateSearches: true)
            }
        }
    }
    func saveQuery(query  q : String, forTag tag: String, syncToCloud sync : Bool) {
        let oldValue = searches.updateValue(q, forKey: tag)
        if oldValue == nil {
            tags.insert(tag, atIndex: 0)
            updateUserDefault(true, updateSearches: true)
        } else {
            updateUserDefault(false, updateSearches: true)
        }
        
        if sync {
            NSUbiquitousKeyValueStore.defaultStore().setObject(q, forKey: tag)
        }
    }
    
    //查询方法
    func tagAtIndex(index : Int) -> String {
        return tags[index]
    }
    func queryForTag(tag : String) -> String {
        return searches[tag]!
    }
    func queryForIndex(index : Int) -> String {
        return queryForTag(tagAtIndex(index))
    }
    var count : Int {
        return tags.count
    }
    
    //删除方法
    func deleteSearchAtIndex(index : Int) {
        searches.removeValueForKey(tags[index])
        let removeTag = tags.removeAtIndex(index)
        updateUserDefault(true, updateSearches: true)
        let keyValueStore = NSUbiquitousKeyValueStore.defaultStore()
        keyValueStore.removeObjectForKey(removeTag)
        
    }
    
    //移动
    func moveTagAtIndex(oldIndex : Int, toDestinationIndex newIndex : Int) {
        let temp = tags.removeAtIndex(oldIndex)
        tags.insert(temp, atIndex: newIndex)
        updateUserDefault(true, updateSearches: true)
        
    }
    
    /**
     *  @author XHJ, 16-04-27 13:04:11
     *
     *  更新
     */
    func updateUserDefault(updateTags : Bool, updateSearches : Bool) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if updateTags {
            userDefault.setObject(tags, forKey: tagsKey)
        }
        if updateSearches {
            userDefault.setObject(updateSearches, forKey: pairsKey)
        }
        //实时保存信息
        userDefault.synchronize()
    }
    
    
}
