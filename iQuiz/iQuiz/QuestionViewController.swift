//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/8/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    fileprivate var answerVC: AnswerViewController!
    fileprivate var mainVC: ViewController!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet var answerBtns: [UIButton]?
    var index: Int = 0
    var currentNo: Int = 1
    var correctAll: Int = 0
    var chooseResult: Bool = false
    var correctAnswerStr: String = ""
    var correctAnswerNum: Int = 0
    
    var url: String = ""
    var descriptions: [String] = []
    var categories: [String] = []
    var questions = [String: [[[String]]]]()
    var answers = [String: [Int]]()
    var score: [String] = []
    var images: [String] = []
//    var mathQuestions: [String] = ["Round 3.864 to the nearest tenth.", "If y(x-1)=z then x=", "Two angles of a triangle measure 15° and 85 °. What is the measure for the third angle?"]
//    var mathAnswers: [Int] = [1, 2, 4]
//
//    var marvelQuestions: [String] = ["What's Captain America's shield made of?", "Who said it? \"You made my men, some of the most highly trained professionals in the world, look like a bunch of minimum-wage mall cops.\"", "How many \"Infinity Stones\" are said to exist in the Marvel Cinematic Universe? (Hint: It's the same as in the comics.)"]
//    var marvelAnswers: [Int] = [4, 3, 2]
//
//    var scienceQuestions: [String] = ["Brass gets discoloured in air because of the presence of which of the following gases in air?", "Which of the following is used in pencils?", "The element common to all acids is"]
//    var scienceAnswers: [Int] = [2, 1, 1]
    
    @IBAction func answerClicked(_ sender: UIButton) {
        for i in 0..<answerBtns!.count {
            if answerBtns![i].titleLabel!.text != sender.titleLabel!.text {
                answerBtns![i].backgroundColor = .white
                answerBtns![i].setTitleColor(self.view.tintColor, for: .normal)
            } else {
                answerBtns![i].backgroundColor = self.view.tintColor
                answerBtns![i].setTitleColor(.white, for: .normal)
                chooseResult = (answerBtns![i].titleLabel!.text == correctAnswerStr)
            }
        }
    }

    fileprivate func answerBuilder() {
        if answerVC == nil {
            answerVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "answerVC")
                as! AnswerViewController
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for answer in answerBtns! {
            answer.layer.cornerRadius = 10
            answer.clipsToBounds = true
            answer.layer.borderColor = self.view.tintColor.cgColor
            answer.layer.borderWidth = 1
        }
        
        questionTitle.text = categories[index] + " (\(currentNo))"
        question.text = questions[categories[index]]![currentNo - 1][0][0]
        answerBtns![0].setTitle(questions[categories[index]]![currentNo - 1][1][0], for: .normal)
        answerBtns![1].setTitle(questions[categories[index]]![currentNo - 1][1][1], for: .normal)
        answerBtns![2].setTitle(questions[categories[index]]![currentNo - 1][1][2], for: .normal)
        answerBtns![3].setTitle(questions[categories[index]]![currentNo - 1][1][3], for: .normal)
        correctAnswerNum = answers[categories[index]]![currentNo - 1] - 1
        correctAnswerStr = answerBtns![correctAnswerNum].titleLabel!.text!
//        if index == 0 {
//            questionTitle.text = "Mathematics (\(currentNo))"
//            question.text = mathQuestions[currentNo - 1]
//            if currentNo == 1 {
//                answers![0].setTitle("3.9", for: .normal)
//                answers![1].setTitle("3.86", for: .normal)
//                answers![2].setTitle("4", for: .normal)
//                answers![3].setTitle("3.96", for: .normal)
//                correctAnswerStr = "3.9"
//            } else if currentNo == 2 {
//                answers![0].setTitle("y - z", for: .normal)
//                answers![1].setTitle("z/y + 1", for: .normal)
//                answers![2].setTitle("y(z - 1)", for: .normal)
//                answers![3].setTitle("z(y - 1)", for: .normal)
//                correctAnswerStr = "z/y + 1"
//            } else if currentNo == 3 {
//                answers![0].setTitle("50°", for: .normal)
//                answers![1].setTitle("55°", for: .normal)
//                answers![2].setTitle("60°", for: .normal)
//                answers![3].setTitle("80°", for: .normal)
//                correctAnswerStr = "80°"
//            }
//        }
//        if index == 1 {
//            question.text = marvelQuestions[currentNo - 1]
//            questionTitle.text = "Marvel Super Heroes (\(currentNo))"
//            if currentNo == 1 {
//                answers![0].setTitle("TITANIUM ALLOY", for: .normal)
//                answers![1].setTitle("MITHRIL", for: .normal)
//                answers![2].setTitle("ADAMANTIUM", for: .normal)
//                answers![3].setTitle("VIBRANIUM", for: .normal)
//                correctAnswerStr = "VIBRANIUM"
//            } else if currentNo == 2 {
//                answers![0].setTitle("TONY STARK", for: .normal)
//                answers![1].setTitle("NICK FURY", for: .normal)
//                answers![2].setTitle("AGENT COULSON", for: .normal)
//                answers![3].setTitle("JUSTIN HAMMER", for: .normal)
//                correctAnswerStr = "AGENT COULSON"
//            } else if currentNo == 3 {
//                answers![0].setTitle("20", for: .normal)
//                answers![1].setTitle("6", for: .normal)
//                answers![2].setTitle("2", for: .normal)
//                answers![3].setTitle("12", for: .normal)
//                correctAnswerStr = "6"
//            }
//        }
//        if index == 2 {
//            question.text = scienceQuestions[currentNo - 1]
//            questionTitle.text = "Science (\(currentNo))"
//            if currentNo == 1 {
//                answers![0].setTitle("Oxygen", for: .normal)
//                answers![1].setTitle("Hydrogen sulphide", for: .normal)
//                answers![2].setTitle("Carbon dioxide", for: .normal)
//                answers![3].setTitle("Nitrogen", for: .normal)
//                correctAnswerStr = "Hydrogen sulphide"
//            } else if currentNo == 2 {
//                answers![0].setTitle("Graphite", for: .normal)
//                answers![1].setTitle("Silicon", for: .normal)
//                answers![2].setTitle("Charcoal", for: .normal)
//                answers![3].setTitle("Phosphorous", for: .normal)
//                correctAnswerStr = "Graphite"
//            } else if currentNo == 3 {
//                answers![0].setTitle("hydrogen", for: .normal)
//                answers![1].setTitle("carbon", for: .normal)
//                answers![2].setTitle("sulphur", for: .normal)
//                answers![3].setTitle("oxygen", for: .normal)
//                correctAnswerStr = "hydrogen"
//            }
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeToAnswer(_ sender: Any) {
        if chooseResult {
            correctAll = correctAll + 1
        }
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        answerBuilder()
        view.window!.layer.add(transition, forKey: kCATransition)
        answerVC.index = self.index
        answerVC.currentNo = self.currentNo
        answerVC.correctAll = self.correctAll
        answerVC.chooseResult = self.chooseResult
        answerVC.correctAnswerStr = self.correctAnswerStr
        answerVC.questionStr = question.text!
        answerVC.answers = self.answers
        answerVC.questions = self.questions
        answerVC.categories = self.categories
        answerVC.descriptions = self.descriptions
        answerVC.url = self.url
        answerVC.score = self.score
        answerVC.images = self.images
        present(answerVC, animated: false, completion: nil)
    }
    
    fileprivate func mainBuilder() {
        if mainVC == nil {
            mainVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "mainVC")
                as! ViewController
        }
    }
    
    @IBAction func backToList(_ sender: Any) {
        mainBuilder()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        mainVC.answers = self.answers
        mainVC.categories = self.categories
        mainVC.questions = self.questions
        mainVC.descriptions = self.descriptions
        mainVC.url = self.url
        mainVC.score = self.score
        mainVC.images = self.images
        present(mainVC, animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
