//
//  Model.swift
//  04-FlagQuiz
//
//  Created by coco on 16/4/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

/*协议*/
protocol ModelDelegate {
    func settingChanges()
}

class Model {
    private let regionsKey = "FlagQuizKeyRegions"
    private let guesssKey = "FlagQuizKeyGuesses"
    
    private var delegate : ModelDelegate! = nil
    
    var  numberOfGuesses = 4   //答案选项
    private var enabledRegions = [  //决定哪个地区可以使用
        "Africa" : false,
        "Asia" : false,
        "Europe" : false,
        "North_America" : true,
        "Oceania" : false,
        "South_America" : false,
    ]
    
    var numberOfQuestions = 10 //问题个数
    private var allCountries : [String] = []  //所有的国家
    private var countriesEnabledRegions : [String] = []   //可以使用的国家
    
    init(delegate : ModelDelegate, numberOfQuestions : Int) {
        self.delegate = delegate
        self.numberOfQuestions = numberOfQuestions
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        //获取选项个数
        let tempGuesses = userDefault.integerForKey(guesssKey)
        if tempGuesses != 0 {
            numberOfGuesses = tempGuesses
        }
        //获取可用地区
        if let tempRegions = userDefault.dictionaryForKey(regionsKey) {
            self.enabledRegions = tempRegions as! [String : Bool]
        }
        //获取所有images
        let paths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: nil) as [NSString]
        
        for path in paths {
            if !path.lastPathComponent.hasPrefix("AppIcon") {
                allCountries.append(path.lastPathComponent)
            }
        }
        regionsChange()
    }
    func regionsChange()  {
        countriesEnabledRegions.removeAll()
        for fileName in allCountries {
            let region = fileName.componentsSeparatedByString("-")[0]
            
            if enabledRegions[region]! {
                countriesEnabledRegions.append(fileName)
            }
        }
    }
    var regions : [String : Bool] {
        return enabledRegions
    }
    var enabledRegionCountries : [String] {
        return countriesEnabledRegions
    }
    
    //更改地区
    func toggleRegion(name : String) {
        enabledRegions[name] = !(enabledRegions[name]!)
        NSUserDefaults.standardUserDefaults().setObject(enabledRegions as NSDictionary, forKey: regionsKey)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        regionsChange()
    }
    
    //设置选项数量
    func setNumberOfGuesses(guesses : Int)  {
        numberOfGuesses = guesses
        NSUserDefaults.standardUserDefaults().setInteger(guesses, forKey: guesssKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //让代理更新数据
    func notifyDelegate() {
        delegate.settingChanges()
    }
    
    //每次产生10新问题
    func newQuizCountries() -> [String] {
        var quizCountries : [String] = []
        var flagCountry = 0
        
        while flagCountry < self.numberOfQuestions {
            let  random = Int(arc4random_uniform(UInt32(enabledRegionCountries.count)))
            
            let fileName = enabledRegionCountries[random]
            
            if quizCountries.filter({$0 == fileName}).count == 0 {
                quizCountries.append(fileName)
                flagCountry += 1
            }
        }
        return quizCountries
        
    }
}

