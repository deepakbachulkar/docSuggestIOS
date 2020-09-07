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
    
    override func awakeFromNib() {
        superview?.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
