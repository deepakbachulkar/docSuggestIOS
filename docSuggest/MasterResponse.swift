//
//  MasterResponse.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 08/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation
//{"VaccineCode":null,"VaccineName":null,"Schedule":null,"AgeDays":null,"addUser":null,"addDate":null,"updateUser":null,"updateDate":null,"deleteUser":null,"deleteDate":null,"MaxKey":"109"}

class Master: Codable {
    public let vaccineCode:String?
    public let vaccineName:String?
    public let schedule:String?
    public let ageDays:String?
    public let addUser:String?
    public let addDate:String?
    public let updateUser:String?
    public let updateDate:String?
    public let deleteUser:String?
    public let deleteDate:String?
    public let MaxKey:String?
}

class MasterServiceAPI {
    
    public static let shared = MasterServiceAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
//    private let apiKey = "PUT_API KEY HERE"
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-mm-dd"
       jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
       return jsonDecoder
    }()
    // Enum Endpoint
     public enum APIServiceError: Error {
           case apiError
           case invalidEndpoint
           case invalidResponse
           case noData
           case decodeError
       }
}
