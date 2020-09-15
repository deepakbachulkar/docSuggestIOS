//
//  InfoDilogViewController.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 13/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import UIKit

class InfoDilogViewController: UIViewController {

    @IBAction func actionUpdate(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var btnUpdate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
           view.backgroundColor = .clear
        // Do any additional setup after loading the view.
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
