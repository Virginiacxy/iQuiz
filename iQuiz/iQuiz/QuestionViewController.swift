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
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var question: UILabel!
    var index: Int = 0
    var currentNo: Int = 1
    var correctAll: Int = 0
    var chooseResult: Bool = false
    var correctAnswerStr: String = ""
    
    var mathQuestions: [String] = ["Round 3.864 to the nearest tenth.", "If y(x-1)=z then x=", "Two angles of a triangle measure 15° and 85 °. What is the measure for the third angle?"]
    var mathAnswers: [Int] = [1, 2, 4]
    
    var marvelQuestions: [String] = ["What's Captain America's shield made of?", "Who said it? \"You made my men, some of the most highly trained professionals in the world, look like a bunch of minimum-wage mall cops.\"", "How many \"Infinity Stones\" are said to exist in the Marvel Cinematic Universe? (Hint: It's the same as in the comics.)"]
    var marvelAnswers: [Int] = [4, 3, 2]
    
    var scienceQuestions: [String] = ["Brass gets discoloured in air because of the presence of which of the following gases in air?", "Which of the following is used in pencils?", "The element common to all acids is"]
    var scienceAnswers: [Int] = [2, 1, 1]
    
    @IBAction func answer1Clicked(_ sender: UIButton) {
        chooseResult = returnResult(selected: 1)
    }
    @IBAction func answer2Clicked(_ sender: UIButton) {
        chooseResult = returnResult(selected: 2)
    }
    @IBAction func answer3Clicked(_ sender: UIButton) {
        chooseResult = returnResult(selected: 3)
    }
    @IBAction func answer4Clicked(_ sender: UIButton) {
        chooseResult = returnResult(selected: 4)
    }
    
    fileprivate func answerBuilder() {
        if answerVC == nil {
            answerVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "answerVC")
                as! AnswerViewController
        }
    }
    

    private func returnResult(selected: Int) -> Bool {
        if index == 0 {
            return selected == mathAnswers[currentNo - 1]
        } else if index == 1 {
            return selected == marvelAnswers[currentNo - 1]
        } else {
            return selected == scienceAnswers[currentNo - 1]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        answer1.layer.cornerRadius = 10
        answer1.clipsToBounds = true
        answer2.layer.cornerRadius = 10
        answer2.clipsToBounds = true
        answer3.layer.cornerRadius = 10
        answer3.clipsToBounds = true
        answer4.layer.cornerRadius = 10
        answer4.clipsToBounds = true
        
        if index == 0 {
            questionTitle.text = "Mathematics (\(currentNo))"
            question.text = mathQuestions[currentNo - 1]
            if currentNo == 1 {
                answer1.setTitle("3.9", for: .normal)
                answer2.setTitle("3.86", for: .normal)
                answer3.setTitle("4", for: .normal)
                answer4.setTitle("3.96", for: .normal)
                correctAnswerStr = "3.9"
            } else if currentNo == 2 {
                answer1.setTitle("y - z", for: .normal)
                answer2.setTitle("z/y + 1", for: .normal)
                answer3.setTitle("y(z - 1)", for: .normal)
                answer4.setTitle("z(y - 1)", for: .normal)
                correctAnswerStr = "z/y + 1"
            } else if currentNo == 3 {
                answer1.setTitle("50°", for: .normal)
                answer2.setTitle("55°", for: .normal)
                answer3.setTitle("60°", for: .normal)
                answer4.setTitle("80°", for: .normal)
                correctAnswerStr = "80°"
            }
        }
        if index == 1 {
            question.text = marvelQuestions[currentNo - 1]
            questionTitle.text = "Marvel Super Heroes (\(currentNo))"
            if currentNo == 1 {
                answer1.setTitle("TITANIUM ALLOY", for: .normal)
                answer2.setTitle("MITHRIL", for: .normal)
                answer3.setTitle("ADAMANTIUM", for: .normal)
                answer4.setTitle("VIBRANIUM", for: .normal)
                correctAnswerStr = "VIBRANIUM"
            } else if currentNo == 2 {
                answer1.setTitle("TONY STARK", for: .normal)
                answer2.setTitle("NICK FURY", for: .normal)
                answer3.setTitle("AGENT COULSON", for: .normal)
                answer4.setTitle("JUSTIN HAMMER", for: .normal)
                correctAnswerStr = "AGENT COULSON"
            } else if currentNo == 3 {
                answer1.setTitle("20", for: .normal)
                answer2.setTitle("6", for: .normal)
                answer3.setTitle("2", for: .normal)
                answer4.setTitle("12", for: .normal)
                correctAnswerStr = "6"
            }
        }
        if index == 2 {
            question.text = scienceQuestions[currentNo - 1]
            questionTitle.text = "Science (\(currentNo))"
            if currentNo == 1 {
                answer1.setTitle("Oxygen", for: .normal)
                answer2.setTitle("Hydrogen sulphide", for: .normal)
                answer3.setTitle("Carbon dioxide", for: .normal)
                answer4.setTitle("Nitrogen", for: .normal)
                correctAnswerStr = "Hydrogen sulphide"
            } else if currentNo == 2 {
                answer1.setTitle("Graphite", for: .normal)
                answer2.setTitle("Silicon", for: .normal)
                answer3.setTitle("Charcoal", for: .normal)
                answer4.setTitle("Phosphorous", for: .normal)
                correctAnswerStr = "Graphite"
            } else if currentNo == 3 {
                answer1.setTitle("hydrogen", for: .normal)
                answer2.setTitle("carbon", for: .normal)
                answer3.setTitle("sulphur", for: .normal)
                answer4.setTitle("oxygen", for: .normal)
                correctAnswerStr = "hydrogen"
            }
        }

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
        present(answerVC, animated: false, completion: nil)
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if chooseResult {
//            correctAll = correctAll + 1
//        }
//        switch segue.identifier! {
//        case "AnswerSegue":
//            let destination = segue.destination as! AnswerViewController
//            destination.currentNo = self.currentNo
//            destination.index = self.index
//            destination.correctAll = self.correctAll
//            destination.chooseResult = self.chooseResult
//            destination.correctAnswerStr = self.correctAnswerStr
//            destination.questionStr = question.text!
//        case "MainSegue":
//            let _ = segue.destination as! ViewController
//        default: NSLog("Unkown segue identifier -- " + segue.identifier!)
//        }
//    }
    
    @IBAction func backToList(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        present((storyboard?.instantiateViewController(withIdentifier: "mainVC"))!, animated: false, completion: nil)
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
