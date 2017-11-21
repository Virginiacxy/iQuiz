//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/8/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    fileprivate var questionVC: QuestionViewController!
    fileprivate var finishVC: FinishViewController!
    fileprivate var mainVC: ViewController!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var currQuestion: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    var chooseResult: Bool = false
    var correctAnswerStr: String = ""
    var correctAll: Int = 0
    var index: Int = 0
    var currentNo: Int = 1
    var questionStr: String = ""
    var categories: [String] = []
    var questions = [String: [[[String]]]]()
    var answers = [String: [Int]]()
    var descriptions: [String] = []
    var url: String = ""
    var score: [String] = []
    var images: [String] = []

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
    
    @IBAction func next(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        if (currentNo < questions[categories[index]]!.count) {
            questionBuilder()
            questionVC.currentNo = self.currentNo + 1
            questionVC.correctAll = self.correctAll
            questionVC.index = self.index
            questionVC.answers = self.answers
            questionVC.questions = self.questions
            questionVC.categories = self.categories
            questionVC.descriptions = self.descriptions
            questionVC.url = self.url
            questionVC.score = self.score
            questionVC.images = self.images
            present(questionVC, animated: false, completion: nil)
        } else {
            finishBuilder()
            finishVC.correctAll = self.correctAll
            finishVC.index = self.index
            finishVC.answers = self.answers
            finishVC.categories = self.categories
            finishVC.questions = self.questions
            finishVC.descriptions = self.descriptions
            finishVC.url = self.url
            finishVC.score = self.score
            finishVC.images = self.images
            present(finishVC, animated: false, completion: nil)
        }
    }

    fileprivate func questionBuilder() {
        if questionVC == nil {
            questionVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "questionVC")
                as! QuestionViewController
        }
    }
    
    fileprivate func finishBuilder() {
        if finishVC == nil {
            finishVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "finishVC")
                as! FinishViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        correctAnswer.text = correctAnswerStr
        if chooseResult {
            resultImage.image = UIImage(named: "correct")
        } else {
            resultImage.image = UIImage(named: "wrong")
        }
        currQuestion.text = questionStr
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
