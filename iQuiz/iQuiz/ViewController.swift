//
//  ViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/5/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    fileprivate var popVC: PopoverViewController!
    fileprivate var scoreVC: ScoreViewController!
    var images: [String] = []
    @IBOutlet weak var tableView: UITableView!
    var quizJsonString: String?
    var categories: [String] = []
    var descriptions: [String] = []
    var questions = [String: [[[String]]]]()
    var answers = [String: [Int]]()
    var score: [String] = []
    var url: String = "https://tednewardsandbox.site44.com/questions.json"
    
    @IBAction func scoreClicked(_ sender: UIBarButtonItem) {
        scoreBuilder()
        scoreVC.score = self.score
        scoreVC.categories = self.categories
        scoreVC.modalPresentationStyle = .popover
        if let popover: UIPopoverPresentationController = scoreVC.popoverPresentationController {
            popover.delegate = self
            popover.barButtonItem = sender
        }
        present(scoreVC, animated: false, completion: nil)
    }
    
    @IBAction func settingClicked(_ sender: UIBarButtonItem) {
        popBuilder()
        popVC.modalPresentationStyle = .popover
        if let popover: UIPopoverPresentationController = popVC.popoverPresentationController {
            popover.delegate = self
            popover.barButtonItem = sender
        }
        present(popVC, animated: false, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller:UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            refreshControl.endRefreshing()
        }
        loadData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if categories.count == 0 {
            loadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "refreshing...")
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func save(_ content: Data) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("data.json")
            guard let JSONString = String(data: content, encoding: String.Encoding.utf8) else {
                return
            }
            do {
                print(JSONString)
                try JSONString.write(to: fileURL, atomically: false, encoding: .utf8)
                print("wrote file")
            }
            catch {
                print(error)
            }
        }
    }
    

    
    func loadData() {
        var data = Data()
        if !isInternetAvailable(){
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent("data.json")
                do {
                    let text = try String(contentsOf: fileURL, encoding: .utf8)
                    data = text.data(using: .utf8)!
                    print("read file")
                    decodeData(data)
                } catch {
                    let alert = UIAlertController(title: "Something went wrong..", message: "You need to connect to Internet for the iQuiz to run successfully for the first time!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
               
            }
        } else {
            guard let url = URL(string: url) else { fatalError("url not found") }
            do {
                data = try Data(contentsOf: url)
                save(data)
                decodeData(data)
            } catch {
                print("URL not found", error)
            }
        }
        
    }
    
    func decodeData(_ data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            self.categories = []
            self.descriptions = []
            self.questions = [String: [[[String]]]]()
            self.answers = [String: [Int]]()
            self.score = []
            self.images = []
            for dict in json! {
                let title = dict["title"] as! String
                self.categories.append(title)
                self.descriptions.append(dict["desc"] as! String)
                self.questions[title] = [[[String]]]()
                self.answers[title] = [Int]()
                
                if let ques = dict["questions"] as? [[String: Any]] {
                    for item in ques {
                        var strs = [[String]]()
                        var str = [String]()
                        if let text = item["text"] as? String {
                            str.append(text)
                        }
                        if str.count != 0 {strs.append(str)}
                        else {
                            strs.append([" "])
                        }
                        if let ans = item["answer"] as? String {
                            self.answers[title]?.append(Int(ans)!)
                        }
                        if let anss = item["answers"] as? [String] {
                            strs.append(anss)
                        }
                        self.questions[title]?.append(strs)
                    }
                }}
            for i in 0..<categories.count {
                score.append("not started yet")
                if (i % 3 == 0) {
                    images.append("1")
                } else if (i % 3 == 1) {
                    images.append("2")
                } else {
                    images.append("3")
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
//    func doTableRefresh() {
//        DispatchQueue.main.async(execute: {
//            self.tableView.reloadData()
//            return
//        })
//    }
    
    // determine if the internet is connected
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    fileprivate func popBuilder() {
        if popVC == nil {
            popVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "popVC")
                as! PopoverViewController
        }
    }
    
    fileprivate func scoreBuilder() {
        if scoreVC == nil {
            scoreVC =
                storyboard?
                    .instantiateViewController(withIdentifier: "scoreVC")
                as! ScoreViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rowClicked = tableView.indexPathForSelectedRow?.row
        switch segue.identifier! {
        case "QuestionSegue":
            let destination = segue.destination as! QuestionViewController
            destination.index = rowClicked!
            destination.categories = self.categories
            destination.questions = self.questions
            destination.answers = self.answers
            destination.descriptions = self.descriptions
            destination.url = self.url
            destination.score = self.score
            destination.images = self.images
        default: NSLog("Unkown segue identifier -- " + segue.identifier!)
        }
    }
}

