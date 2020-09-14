//
//  MainTableViewCell.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 06/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation
import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sr: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var del: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        superview?.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
