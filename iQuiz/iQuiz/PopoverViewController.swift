//
//  PopoverViewController.swift
//  iQuiz
//
//  Created by Xinyue Chen on 11/15/17.
//  Copyright © 2017 Xinyue Chen. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        dismiss()
    }
    
    @IBAction func deleteFile(_ sender: Any) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("data.json")
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch let error as NSError {
                print("Error: \(error.domain)")
            }
        }
    }
    
    @IBAction func AlternativeBtnClicked(_ sender: UIButton) {
        textField.text = "https://cdn.rawgit.com/uwadmin/b583231b7dfa52dcdd00bc847bd57ea5/raw/9c32101231d70c780710edc7a69cbcbc6042036e/data.json"
    }
    
    @IBAction func checkBtnPressed(_ sender: UIButton) {
        let mainVC: ViewController = presentingViewController as! ViewController
        NSLog(textField.text!)
        if mainVC.isInternetAvailable() {
            if let url = textField.text, !url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty && UIApplication.shared.canOpenURL(URL(string: textField.text!)!) {
                let alert = UIAlertController(title: "Success", message: "Update successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                mainVC.url = url
                mainVC.loadData()
                mainVC.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error", message: "Invalid URL input", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Something went wrong..", message: "You need to connect to Internet for the iQuiz to load online data!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = ""
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
