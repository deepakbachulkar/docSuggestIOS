//
//  TransactionDetailsVO.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 13/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation

struct TransactionDetails: Codable {
  let VaccineCode: String
  let VaccineName: String
  let Schedule: String
  let AgeDays: String
  let comment: String

  init(VaccineCode: String, VaccineName: String,  Schedule:String, AgeDays: String, comment: String) {
        self.VaccineCode = VaccineCode
        self.VaccineName = VaccineName
        self.AgeDays = AgeDays
        self.Schedule = Schedule
        self.comment = comment
  }
}
