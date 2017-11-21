//
//  ScoreViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/18/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet weak var scoreField: UILabel!
    var categories: [String] = []
    var score: [String] = []
    var finalScore: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        finalScore = ""
        for i in 0..<categories.count {
            NSLog(score[i])
            finalScore += categories[i] + ": " + score[i] + "\n"
        }
        scoreField.text = finalScore
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
