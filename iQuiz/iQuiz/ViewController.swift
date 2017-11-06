//
//  ViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/5/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let subjects: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let desc: [String] = ["1+1", "Marvel questions", "explore the world"]
    let images: [String] = ["1", "2", "3"]
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func settingClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell \(indexPath.row)!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = desc[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        
        return cell
//        let cell: UITableViewCell
//        if let newCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
//            cell = newCell
//        } else {
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        }
////        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
////        if cell == nil {
////            cell = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: "cell")
////        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

