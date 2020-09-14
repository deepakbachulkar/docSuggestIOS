//
//  NetworkManager.swift
//  docSuggest
//
//  Created by Deepak Bachulkar on 13/09/20.
//  Copyright © 2020 Deepak Bachulkar. All rights reserved.
//

import Foundation

final class NetworkManager {

  var films: [MasterResponse] = []
  private let domainUrlString = "http://162.241.174.229/"
  
//    http://162.241.174.229/allVaccineMaster.php
  func fetchMaster(completionHandler: @escaping ([MasterVO]) -> Void) {
    let url = URL(string: domainUrlString + "allVaccineMaster.php")!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
        return
      }
      if let data = data,
        let masterResponse = try? JSONDecoder().decode([MasterVO].self, from: data) {
        completionHandler(masterResponse)
      }
    })
    task.resume()
  }

//  private func fetchFilm(withID id:Int, completionHandler: @escaping (Film) -> Void) {
//    let url = URL(string: domainUrlString + "films/\(id)")!
//
//    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//      if let error = error {
//        print("Error returning film id \(id): \(error)")
//        return
//      }
//
//      guard let httpResponse = response as? HTTPURLResponse,
//        (200...299).contains(httpResponse.statusCode) else {
//        print("Unexpected response status code: \(response)")
//        return
//      }
//
//      if let data = data,
//        let film = try? JSONDecoder().decode(Film.self, from: data) {
//          completionHandler(film)
//      }
//    }
//    task.resume()
//  }
}
