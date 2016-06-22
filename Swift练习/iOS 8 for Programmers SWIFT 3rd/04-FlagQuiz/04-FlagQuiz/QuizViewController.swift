//
//  ViewController.swift
//  04-FlagQuiz
//
//  Created by coco on 16/4/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, ModelDelegate {
    /*图片*/
    @IBOutlet weak var logoImageV: UIImageView!
    /*当前问题数量*/
    @IBOutlet weak var questionNubmerL: UILabel!
    /*问题答案提示*/
    @IBOutlet weak var answerL: UILabel!
    /*outlet集合属性*/
    @IBOutlet var segmentedControls: [UISegmentedControl]!
    
    /*segment 选择方法*/
    @IBAction func submitGuess(sender: UISegmentedControl) {
        print(sender.titleForSegmentAtIndex(sender.selectedSegmentIndex), terminator:"")
    }
    
    
    //代理方法
    func settingChanges() {
        enabledCountries = model.enabledRegionCountries
        resetQuiz()
    }
    
    private var model : Model!
    private let correctColor = UIColor(red: 0, green: 0.75, blue: 0, alpha: 1)
    private let incorrectColor = UIColor.redColor()
    private var quizCountries : [String]! = nil
    private var enabledCountries : [String]! = nil
    private var correntAnswer  : String! = nil
    private var correntGuesses = 0
    private var totalGuesses = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = Model(delegate: self, numberOfQuestions: 10)
        settingChanges()
    }

    func resetQuiz() {
        quizCountries = model.newQuizCountries()
        correntGuesses = 0
        totalGuesses = 0
        
        
    }


}

