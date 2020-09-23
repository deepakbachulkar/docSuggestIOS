//
//  DatabaseMaster.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 13/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation
import SQLite3

class DatabseMaster
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "moPhorma.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS dbTblVacCalMst(VaccineCode TEXT,VaccineName TEXT,AgeDays TEXT,Shedule TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("dbTblVacCalMst table created.")
            } else {
                print("dbTblVacCalMst table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
        

        
        let createTansMasterString = "CREATE TABLE IF NOT EXISTS dbTblVacTransMst(Id INTEGER PRIMARY KEY, framName TEXT, Schedule TEXT,date TEXT);"
             var createTansMasterTableStatement: OpaquePointer? = nil
             if sqlite3_prepare_v2(db, createTansMasterString, -1, &createTansMasterTableStatement, nil) == SQLITE_OK
             {
                 if sqlite3_step(createTansMasterTableStatement) == SQLITE_DONE
                 {
                     print("dbTblVacTransMst table created.")
                 } else {
                     print("dbTblVacTransMst table could not be created.")
                 }
             } else {
                 print("CREATE TABLE statement could not be prepared.")
             }
             sqlite3_finalize(createTansMasterTableStatement)
        
        let createTansDetailString = "CREATE TABLE IF NOT EXISTS dbTblVacTransDetails(Id INTEGER PRIMARY KEY, VaccineCode TEXT,VaccineName TEXT,Schedule TEXT, AgeDays INTEGER, comment TEXT, MasterId INTEGER );"
                 var createTansDetailsTableStatement: OpaquePointer? = nil
                 if sqlite3_prepare_v2(db, createTansDetailString, -1, &createTansDetailsTableStatement, nil) == SQLITE_OK
                 {
                     if sqlite3_step(createTansDetailsTableStatement) == SQLITE_DONE
                     {
                         print("dbTblVacTransDetails table created.")
                     } else {
                         print("dbTblVacTransDetails table could not be created.")
                     }
                 } else {
                     print("CREATE TABLE statement could not be prepared.")
                 }
                 sqlite3_finalize(createTansDetailsTableStatement)
   
    }
    
    
    func insert(item:MasterVO)
    {
        let insertStatementString = "INSERT INTO dbTblVacCalMst (VaccineCode, VaccineName, AgeDays, Shedule) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (item.VaccineCode as! NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (item.VaccineName as! NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (item.AgeDays as! NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (item.Schedule as! NSString).utf8String, -1, nil)
        
            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func inserts(data:[MasterVO])
       {
           let varVacCalMst = read()
           let insertStatementString = "INSERT INTO dbTblVacCalMst (VaccineCode, VaccineName, AgeDays, Shedule) VALUES (?, ?, ?, ?);"
           var insertStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               for item in data {
                   if(!varVacCalMst.isEmpty){
                       for p in varVacCalMst{
                           if p.VaccineCode == item.VaccineCode {
                               break
                           }
                       }
                   }
                sqlite3_bind_text(insertStatement, 1, (item.VaccineCode as! NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (item.VaccineName as! NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (item.AgeDays as! NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (item.Schedule as! NSString).utf8String, -1, nil)
               }
               
               if sqlite3_step(insertStatement) == SQLITE_DONE {
//                   print("Successfully inserted row.")
               } else {
                   print("Could not insert row.")
               }
           } else {
               print("INSERT statement could not be prepared.")
           }
           sqlite3_finalize(insertStatement)
       }
       
  
    
    func read() -> [MasterVO] {
        let queryStatementString = "SELECT * FROM dbTblVacCalMst group by AgeDays;"
        var queryStatement: OpaquePointer? = nil
        var psns : [MasterVO] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
              let  VaccineCode = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let VaccineName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let AgeDays = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let Shedule = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                    
                psns.append(MasterVO(
                                VaccineCode: VaccineCode,
                                VaccineName: VaccineName,
                                AgeDays: AgeDays,
                                Schedule: Shedule))
//                print("Query Result:")
//                print("\(VaccineCode) | \(VaccineName) | \(Shedule) | \(AgeDays)" )
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func readSingleScheduler( scheduler: String) -> [MasterVO] {
            let queryStatementString = "SELECT * FROM dbTblVacCalMst WHERE Shedule LIKE '"+scheduler+"'"
            var queryStatement: OpaquePointer? = nil
            var psns : [MasterVO] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                  let  VaccineCode = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                    let VaccineName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let AgeDays = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let Shedule = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                    psns.append(MasterVO(
                                    VaccineCode: VaccineCode,
                                    VaccineName: VaccineName,
                                    AgeDays: AgeDays,
                                    Schedule: Shedule))
               }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return psns
        }
    
    func deleteByVaccineCode(id:Int) {
        let deleteStatementStirng = "DELETE FROM dbTblVacCalMst WHERE VaccineCode = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    
//    Mark Insert transction Master
    func insertTransMaster(data:TransactionMaster) -> Int {
           var lastRowId = 0
           let insertStatementString = "INSERT INTO dbTblVacTransMst (framName, Schedule, date) VALUES ( ?, ?, ?);"
           var insertStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, (data.framName as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (data.Schedule as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (data.date as NSString).utf8String, -1, nil)
           if sqlite3_step(insertStatement) == SQLITE_DONE {
                lastRowId = Int(sqlite3_last_insert_rowid(db));
                print(lastRowId) // its gives you last insert
            } else {
                print("Could not insert row.")
            }
           }else {
                print("INSERT statement could not be prepared.")
           }
           sqlite3_finalize(insertStatement)
        return Int(lastRowId)
   }
    
//    Mark: Insert transaction table
//    Id INTEGER PRIMARY KEY, VaccineCode TEXT,VaccineName TEXT,Schedule TEXT, AgeDays INTEGER, comment TEXT, MasterId INTEGER
    func insertTransDetails(id:Int, data:TransactionDetails) -> Int {
            var lastRowId = 0
            let insertStatementString = "INSERT INTO dbTblVacTransDetails (VaccineCode, VaccineName, Schedule,AgeDays, comment, MasterId) VALUES ( ?, ?, ?, ? , ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                 sqlite3_bind_text(insertStatement, 1, (data.VaccineCode as NSString).utf8String, -1, nil)
                 sqlite3_bind_text(insertStatement, 2, (data.VaccineName as NSString).utf8String, -1, nil)
                 sqlite3_bind_text(insertStatement, 3, (data.Schedule as NSString).utf8String, -1, nil)

                sqlite3_bind_text(insertStatement, 4, (data.AgeDays as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (data.comment as NSString).utf8String, -1, nil)
                sqlite3_bind_int(insertStatement,  6, Int32(data.masterId))
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                 lastRowId = Int(sqlite3_last_insert_rowid(db));
                 print(lastRowId) // its gives you last insert
             } else {
                 print("Could not insert row.")
             }
            }else {
                 print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
         return Int(lastRowId)
    }
    
     func readTransDetailsList() -> [TransactionDetails] {
            let queryStatementString = "SELECT * FROM dbTblVacTransDetails group by AgeDays;"
            var queryStatement: OpaquePointer? = nil
            var psns : [TransactionDetails] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let  id = sqlite3_column_int(queryStatement, 0)
                    let  VaccineCode = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let VaccineName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let Schedule = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                    let AgeDays = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                    let comment = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                    let masterId = sqlite3_column_int(queryStatement, 6)
                    
                        
                    psns.append(TransactionDetails(
                        id:Int(id),
                                    VaccineCode: VaccineCode,
                                    VaccineName: VaccineName,
                                    Schedule: Schedule, AgeDays: AgeDays,
                                    comment: comment,
                                    masterId: Int(masterId)))
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return psns
        }
   
    func updateTransDetails(transDetails:TransactionDetails) {
      var updateStatement: OpaquePointer?
        let updateStatementString = "UPDATE dbTblVacTransDetails SET VaccineName = '\(transDetails.VaccineName)', AgeDays = '\(transDetails.AgeDays)', comment = '\(transDetails.comment)' WHERE Id = \(transDetails.id);"
      if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(updateStatement) == SQLITE_DONE {
          print("\nSuccessfully updated row.")
        } else {
          print("\nCould not update row.")
        }
      } else {
        print("\nUPDATE statement is not prepared")
      }
      sqlite3_finalize(updateStatement)
    }
    
    func deleteByTransDetails(id:Int) {
        let deleteStatementStirng = "DELETE FROM dbTblVacTransDetails WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
