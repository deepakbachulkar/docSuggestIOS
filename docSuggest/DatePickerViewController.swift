//
//  DatePickerViewController.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 20/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    var selectDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
            view.backgroundColor = .clear
            
        // Do any additional setup after loading the view.
    }
    



    @IBAction func dat_picker_action(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        selectDate = dateFormatter.string(from:datePicker.date)
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
  
    @IBAction func select_action(_ sender: Any) {
         Constants.selectedDate = selectDate
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel_action(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
}
