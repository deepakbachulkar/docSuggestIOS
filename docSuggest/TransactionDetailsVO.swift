//
//  TransactionDetailsVO.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 13/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation

struct TransactionDetails: Codable {
  var id:Int = 0
  let VaccineCode: String
  var VaccineName: String
  let Schedule: String
  var AgeDays: String
  var comment: String
    var masterId:Int = 0

  init(VaccineCode: String, VaccineName: String,  Schedule:String, AgeDays: String, comment: String) {
        self.VaccineCode = VaccineCode
        self.VaccineName = VaccineName
        self.AgeDays = AgeDays
        self.Schedule = Schedule
        self.comment = comment
  }
    init(id:Int, VaccineCode: String, VaccineName: String,  Schedule:String, AgeDays: String, comment: String, masterId:Int) {
          self.id = id
          self.VaccineCode = VaccineCode
          self.VaccineName = VaccineName
          self.AgeDays = AgeDays
          self.Schedule = Schedule
          self.comment = comment
          self.masterId = masterId
    }
}

struct TransactionMaster: Codable {
    var id :Int = 0
  let framName: String
  let Schedule: String
  let date: String

  init(framName: String,  Schedule:String, date: String) {
        self.framName = framName
        self.Schedule = Schedule
        self.date = date
  }
    init(id:Int, framName: String,  Schedule:String, date: String) {
          self.id = id
          self.framName = framName
          self.Schedule = Schedule
          self.date = date
    }
}
