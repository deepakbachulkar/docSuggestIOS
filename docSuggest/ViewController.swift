//
//  ViewController.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 06/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scheduleTableView: UITableView!
    var array1 = ["AAAA", "BBBBB"]
    
    @IBAction func onClick(_ sender: UIButton) {
        if(self.scheduleTableView.isHidden){
            self.scheduleTableView.isHidden = false
        } else {
            self.scheduleTableView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scheduleTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(scheduleTableView == tableView){
            return array1.count
        }else{
            return array1.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(scheduleTableView == tableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell")
            cell?.textLabel?.text = array1[indexPath.row]
            return cell!
        }else{
            let cell:MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainTableViewCell
//            cell?.textLabel?.text = array1[indexPath.row]
            return cell
        }
            
    }
    
    
}

