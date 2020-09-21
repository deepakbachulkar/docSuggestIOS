//
//  ViewController.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 06/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var framName: UITextField!
    var selectedDate = "09-09-2020"
    var masterList = [MasterVO]()
    var transcationDetailsList = [TransactionDetails]()
    var db:DatabseMaster = DatabseMaster()
    
    @IBOutlet weak var btnScheduler: UIButton!
    @IBOutlet weak var tableViewMain: UITableView!
    @IBOutlet weak var scheduleTableView: UITableView!
    
    @IBOutlet weak var textDate: UIButton!
    @IBAction func calculate(_ sender: Any) {
        let value = btnScheduler.currentTitle
        if(value != "Select Scheduler" ){
            calcuteTransaction(scheduler:value ?? "")
        }
    }
    
    @IBAction func date_action(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "date_picker")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
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
        textDate.setTitle(Utils().getToday(), for: .normal)
        apiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedDate = Constants.selectedDate
        textDate.setTitle(selectedDate, for: .normal)
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
            
            let date = Utils().convertNextDate(date: selectedDate, days: Int(item.AgeDays) ?? 0)
            cell.date?.text = date
            cell.month?.text =  Utils().convertDateToMonth(date: date)
            return cell
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(scheduleTableView == tableView){
            let value: String  = self.masterList[indexPath.row].Schedule ?? ""
            print(value)
            self.scheduleTableView.isHidden = true
            self.btnScheduler.setTitle(value, for: .normal)
        }else{
            if(isValid()){
                let selectedTransactionMaster = TransactionMaster(framName: framName.text ?? "", Schedule: btnScheduler.currentTitle ?? "", date: selectedDate)
                let transcationDetails = transcationDetailsList[indexPath.row]
                Constants.selectedTransactionDetails = transcationDetails
                Constants.selectedTransactionMaster = selectedTransactionMaster
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myAlert = storyboard.instantiateViewController(withIdentifier: "info")
                myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func isValid() -> Bool {
        let value = btnScheduler.currentTitle
        if(framName.text == nil || framName.text == ""){
            return false
        }
        else if(value==nil || value == "Select Scheduler" ){
            return false
        }
        else{
            return true
        }
    }
    
    func apiCall(){
        let list = db.read()
        if(list.count == 0){
            NetworkManager().fetchMaster{(masters) in
                for it in masters{
                    self.db.insert(item: it)
                }
                
                DispatchQueue.main.async{
                    self.masterList = self.db.read()
                    self.scheduleTableView.reloadData()
                }
            }
        }else{
            self.masterList = list
            self.scheduleTableView.reloadData()
        }
        
    }
    
    func calcuteTransaction(scheduler:String){
        let list:[MasterVO] = db.readSingleScheduler(scheduler: scheduler)
        transcationDetailsList = [TransactionDetails]()
        for item in list {
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

    //    func showDatePicker(){
//           //Formate Date
//           datePicker.datePickerMode = .date
//
//           //ToolBar
//           let toolbar = UIToolbar();
//           toolbar.sizeToFit()
//
//
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: "donedatePicker")
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: "cancelDatePicker")
//           toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//           textDateView.inputAccessoryView = toolbar
//           textDateView.inputView = datePicker
//
//       }
//
//       func donedatePicker(){
//           let formatter = DateFormatter()
//           formatter.dateFormat = "dd/MM/yyyy"
//            textDateView.text = formatter.string(from: datePicker.date)
//           self.view.endEditing(true)
//       }
//
//       func cancelDatePicker(){
//           self.view.endEditing(true)
//       }
}
