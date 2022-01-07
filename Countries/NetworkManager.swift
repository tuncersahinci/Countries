//
//  NetworkManager.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//

import SwiftUI

struct Countries: Codable {
  let data: [CountryResult]
}

struct CountryResult: Codable, Identifiable, Hashable {
  let code: String
  let name: String
  var id: String { code }
  
  enum CodingKeys: String, CodingKey {
    case code, name
  }
}

struct CountryDetail: Codable {
  let data: CountryDetails
  
}
struct CountryDetails: Codable {
  let name: String
  let code: String
  let flagImageURI: String
  let wikiDataID: String
  
  enum CodingKeys: String, CodingKey {
    case wikiDataID = "wikiDataId"
    case flagImageURI = "flagImageUri"
    case name, code
  }
}

class CountryService: ObservableObject {
  
  func fetchCountries(completion:@escaping (Countries) -> ()) {
    let headers = [
      "x-rapidapi-host": Constants.host,
      "x-rapidapi-key": Constants.apiKey
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10&offset=10")! as URL,
                                      cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error)  in
      do {
        if let data = data {
          let result = try JSONDecoder().decode(Countries.self, from: data)
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            completion(result)
          }
        } else {
          print("No data")
        }
      }
      catch(let error) {
        debugPrint(error)
      }
    }).resume()
  }
  
  func fetchCountryDetails(countryCode: String, completion:@escaping (CountryDetail) -> ()) {
    let headers = [
      "x-rapidapi-host": Constants.host,
      "x-rapidapi-key": Constants.apiKey
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(countryCode)")! as URL,
                                      cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error)  in
      do {
        if let data = data {
          let result = try JSONDecoder().decode(CountryDetail.self, from: data)
          DispatchQueue.main.async {
            completion(result)
          }
        } else {
          print("No data")
        }
      }
      catch(let error) {
        debugPrint(error)
      }
    }).resume()
  }
}


