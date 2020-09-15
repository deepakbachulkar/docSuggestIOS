//
//  Utils.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 14/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation

class Utils {
    

    func getToday() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    func convertNextDate(date : String, days:Int) ->  String{
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd-MM-yyyy"
          let myDate = dateFormatter.date(from: date)!
          let tomorrow = Calendar.current.date(byAdding: .day, value: days, to: myDate)
          let somedateString = dateFormatter.string(from: tomorrow!)
          print("your next Date is \(somedateString)")
          return somedateString
      }
      
      func convertDateToMonth(date : String) ->  String{
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd-MM-yyyy"
          let myDate = dateFormatter.date(from: date)!
          dateFormatter.dateFormat = "MMM"
          let somedateString = dateFormatter.string(from: myDate)
          print("your next Date is \(somedateString)")
          return somedateString
      }
}
