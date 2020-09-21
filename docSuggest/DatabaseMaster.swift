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
    }
    
    
    func insert(item:MasterVO)
    {
//        let varVacCalMst = read()
//        for p in varVacCalMst{
//            if p.VaccineCode == item.VaccineCode {
//                break
//            }
//        }
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
    //                print("Query Result:")
    //                print("\(VaccineCode) | \(VaccineName) | \(Shedule) | \(AgeDays)" )
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
    
}
