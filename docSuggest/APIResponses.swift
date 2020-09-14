//
//  APIResponses.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 13/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation

struct MasterResponse: Codable {
   let userMaster: MasterVO
   let MaxKey:String
}

struct AllShedulerResponse: Codable {
   let userMaster: [MasterVO]
}


