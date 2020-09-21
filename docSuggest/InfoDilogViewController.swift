//
//  InfoDilogViewController.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 13/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import UIKit

class InfoDilogViewController: UIViewController {

    
    @IBOutlet weak var btnUpdate: UIButton!
    
   
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var comment: UITextView!
    
    @IBAction func outside_age(_ sender: Any) {
        print("outside_age")
    }
    
    @IBAction func ageAction(_ sender: Any) {
            print("action")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = .clear
        // Do any additional setup after loading the view.
        let master = Constants.selectedTransactionMaster
        let details = Constants.selectedTransactionDetails
        header.text = master?.framName
        age.text = details?.AgeDays
        date.text = Utils().convertNextDate(date: master?.date ?? "", days: Int(details?.AgeDays ?? "0") ?? 0)
        name.text = details?.VaccineName
        comment.text = details?.comment
        
    }
    
    @IBAction func actionUpdate(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
