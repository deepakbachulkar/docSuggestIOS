//
//  ViewController.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 06/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var btnScheduler: UIButton!
    var selectedDate = "09-09-2020"
    
    @IBOutlet weak var tableViewMain: UITableView!
    @IBOutlet weak var scheduleTableView: UITableView!
    var masterList = [MasterVO]()
    var transcationDetailsList = [TransactionDetails]()
    var db:DatabseMaster = DatabseMaster()
    
    @IBAction func calculate(_ sender: Any) {
        let value = btnScheduler.currentTitle
        if(value != "Select Scheduler" ){
            calcuteTransaction(scheduler:value ?? "")
        }
    }
    
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
        apiCall()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(scheduleTableView == tableView){
            return self.masterList.count
        }else{
            return transcationDetailsList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(scheduleTableView == tableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell")
            cell?.textLabel?.text = self.masterList[indexPath.row].Schedule
            return cell!
        }else{
            let cell:MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainTableViewCell
            let item =  transcationDetailsList[indexPath.row]
            cell.sr?.text = String(indexPath.row)
            cell.age?.text = item.AgeDays
            
            cell.name?.text = item.VaccineName
            cell.comment?.text = item.comment
            
            let date = convertNextDate(date: selectedDate, days: Int(item.AgeDays) ?? 0)
            cell.date?.text = date
            cell.month?.text = convertDateToMonth(date: date)
            return cell
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(scheduleTableView == tableView){
//            print(indexPath.row)
            let value: String  = self.masterList[indexPath.row].Schedule ?? ""
            print(value)
            self.scheduleTableView.isHidden = true
            self.btnScheduler.setTitle(value, for: .normal)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let myAlert = storyboard.instantiateViewController(withIdentifier: "info")
                   myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                   myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                   self.present(myAlert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    func apiCall(){
        NetworkManager().fetchMaster{(masters) in
            for it in masters{
                self.db.insert(item: it)
            }
            
            DispatchQueue.main.async{
                self.masterList = self.db.read()
                self.scheduleTableView.reloadData()
            }
        }
    }
    
    func calcuteTransaction(scheduler:String){
        let list:[MasterVO] = db.readSingleScheduler(scheduler: scheduler)
        transcationDetailsList = [TransactionDetails]()
        for item in list {
//            let days:Int = Int(item.AgeDays ?? "0") ?? 0
            transcationDetailsList.append(
                TransactionDetails(
                    VaccineCode: item.VaccineCode ?? "",
                    VaccineName: item.VaccineName ?? "",
                    Schedule: item.Schedule ?? "",
                    AgeDays: item.AgeDays ?? "0",
                    comment: ""
                )
            )
        }
        
        self.tableViewMain.reloadData()
        
    }

    final class ContentSizedTableView: UITableView {
        override var contentSize:CGSize {
            didSet {
                invalidateIntrinsicContentSize()
            }
        }

        override var intrinsicContentSize: CGSize {
            layoutIfNeeded()
            return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
        }
    }
    
    
    func convertNextDate(date : String, days:Int) ->  String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let myDate = dateFormatter.date(from: date)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: days, to: myDate)
        let somedateString = dateFormatter.string(from: tomorrow!)
        print("your next Date is \(somedateString)")
        return somedateString
    }
    
    func convertDateToMonth(date : String) ->  String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let myDate = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "MMM"
        let somedateString = dateFormatter.string(from: myDate)
        print("your next Date is \(somedateString)")
        return somedateString
    }
}
