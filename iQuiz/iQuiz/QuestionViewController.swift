//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/8/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionTable: UITableView!
    var index: Int = 0
    
    var mathQuestions: [String] = ["Round 3.864 to the nearest tenth.", "If y(x-1)=z then x=", "Two angles of a triangle measure 15° and 85 °. What is the measure for the third angle?"]
    var mathAnswers1: [String] = ["3.9", "3.86", "4", "3.96"]
    var mathAnswer1: String = "3.9"
    var mathAnswers2: [String] = ["y - z", "z/y + 1", "y(z - 1)", "z(y - 1)"]
    var mathAnswer2: String = "z/y + 1"
    var mathAnswers3: [String] = ["50° ", "55° ", "60° ", "80° "]
    var mathAnswer3: String = "80° "
    
    var marvelQuestions: [String] = ["What's Captain America's shield made of?", "Who said it? \"You made my men, some of the most highly trained professionals in the world, look like a bunch of minimum-wage mall cops.\"", "How many \"Infinity Stones\" are said to exist in the Marvel Cinematic Universe? (Hint: It's the same as in the comics.)"]
    var marvelAnswers1: [String] = ["TITANIUM ALLOY", "MITHRIL", "ADAMANTIUM", "VIBRANIUM"]
    var marvelAnswer1: String = "VIBRANIUM"
    var marvelAnswers2: [String] = ["TONY STARK", "NICK FURY", "AGENT COULSON", "JUSTIN HAMMER"]
    var marvelAnswer2: String = "AGENT COULSON"
    var marvelAnswers3: [String] = ["20", "6", "2", "12"]
    var marvelAnswer3: String = "6"
    
    var scienceQuestions: [String] = ["Brass gets discoloured in air because of the presence of which of the following gases in air?", "Which of the following is used in pencils?", "The element common to all acids is"]
    var scienceAnswers1: [String] = ["Oxygen", "Hydrogen sulphide", "Carbon dioxide", "Nitrogen"]
    var scienceAnswer1: String = "Hydrogen sulphide"
    var ScienceAnswers2: [String] = ["Graphite", "Silicon", "Charcoal", "Phosphorous"]
    var ScienceAnswer2: String = "Graphite"
    var ScienceAnswers3: [String] = ["hydrogen", "carbon", "sulphur", "oxygen"]
    var ScienceAnswer3: String = "hydrogen"
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.marvelQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath as IndexPath)
        cell.textLabel?.text = marvelQuestions[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionTable.register(UITableViewCell.self, forCellReuseIdentifier: "questionCell")
        NSLog("\(index)")
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
