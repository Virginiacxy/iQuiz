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
    @IBOutlet weak var descriptive: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    var correctAll: Int = 0
    var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if index == 2 {
            nextBtn.isHidden = true
        }
        score.text = "Score: \(correctAll) / 3"
        if correctAll == 3 {
            descriptive.text = "Perfect!"
        } else if correctAll == 2 {
            descriptive.text = "Almost!"
        } else {
            descriptive.text = "Maybe next time!"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeToNext(_ sender: Any) {
        if index != 2 {
            questionBuilder()
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            questionVC.index = self.index + 1
            present(questionVC, animated: false, completion: nil)
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
