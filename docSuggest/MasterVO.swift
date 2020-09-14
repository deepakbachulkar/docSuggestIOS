//
//  Schedule.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 06/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation

struct MasterVO: Codable {
  let VaccineCode: String?
  let VaccineName: String?
  let Schedule: String?
  let AgeDays: String?

  init(VaccineCode: String, VaccineName: String, AgeDays: String, Schedule:String) {
        self.VaccineCode = VaccineCode
        self.VaccineName = VaccineName
        self.AgeDays = AgeDays
        self.Schedule = Schedule
     
  }
}
