//
//  Favorites.swift
//  Countries
//
//  Created by Tuncer Şahinci on 5.01.2022.
//

import SwiftUI

class Favorites: ObservableObject {
  private var countries: Set<String>
  
  private let saveKey = "Favorites"
  
  init() {
    self.countries = []
    
    self.load()
  }
  
  func contains(_ countryCode: String) -> Bool {
    countries.contains(countryCode)
  }
  
  func add(_ countryCode: String) {
    objectWillChange.send()
    countries.insert(countryCode)
    save()
  }
  
  func remove(_ countryCode: String) {
    objectWillChange.send()
    countries.remove(countryCode)
    save()
  }
  
  func save() {
    do {
      let fileName = getDocumentsDirectory().appendingPathComponent("SavedCountries")
      let countryIds = Array(self.countries)
      let data = try JSONEncoder().encode(countryIds)
      try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
      print("Country data saved")
    } catch {
      print("Unable to save data")
    }
  }
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func load() {
    let fileName = getDocumentsDirectory().appendingPathComponent("SavedCountries")
    do {
      let data = try Data(contentsOf: fileName)
      let countryIds = try JSONDecoder().decode([String].self, from: data)
      countries = Set(countryIds)
    } catch {
      print("Unable to load saved data.")
    }
  }
}
