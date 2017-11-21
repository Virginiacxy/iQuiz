//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/8/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    fileprivate var questionVC: QuestionViewController!
    fileprivate var mainVC: ViewController!
    @IBOutlet weak var descriptive: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    var categories: [String] = []
    var questions = [String: [[[String]]]]()
    var answers = [String: [Int]]()
    var correctAll: Int = 0
    var index: Int = 0
    var descriptions: [String] = []
    var url: String = ""
    var questionNum = 0
    var score: [String] = []
    var images: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionNum = questions[categories[index]]!.count
        if index == categories.count - 1 {
            nextBtn.isHidden = true
            self.view.gestureRecognizers?.popLast()
        }
        scoreLabel.text = "Score: \(correctAll) / \(questionNum)"
        if correctAll == questionNum {
            descriptive.text = "Perfect!"
            images[index] = "perfect"
        } else if correctAll == 0 {
            descriptive.text = "Maybe next time!"
            images[index] = "bad"
        } else {
            descriptive.text = "Almost!"
            images[index] = "medium"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeToNext(_ sender: Any) {
        questionBuilder()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        questionVC.index = self.index + 1
        questionVC.answers = self.answers
        questionVC.categories = self.categories
        questionVC.questions = self.questions
        questionVC.descriptions = self.descriptions
        questionVC.url = self.url
        questionVC.score = self.score
        questionVC.score[index] = "\(correctAll) / \(questionNum)"
        questionVC.images = self.images
        present(questionVC, animated: false, completion: nil)
    }
    
    fileprivate func questionBuilder() {
        if questionVC == nil {
            questionVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "questionVC")
                as! QuestionViewController
        }
    }
    
    fileprivate func mainBuilder() {
        if mainVC == nil {
            mainVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "mainVC")
                as! ViewController
        }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier! {
//        case "QuestionSegue":
//            let destination = segue.destination as! QuestionViewController
//            destination.index = self.index + 1
//        case "MainSegue":
//            let _ = segue.destination as! ViewController
//        default: NSLog("Unkown segue identifier -- " + segue.identifier!)
//        }
//    }

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
        mainVC.score = score
        mainVC.score[index] = "\(correctAll) / \(questionNum)"
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
