//
//  Favorites.swift
//  Countries
//
//  Created by Tuncer Şahinci on 5.01.2022.
//

import SwiftUI

class Favorites: ObservableObject {
  var countryCodes: Set<String>
  
  private let saveKey = "Favorites"
  
  init() {
    self.countryCodes = []
    self.load()
  }
  
  func contains(_ countryCode: String) -> Bool {
    countryCodes.contains(countryCode)
  }
  
  func add(_ countryCode: String) {
    objectWillChange.send()
    countryCodes.insert(countryCode)
    save()
  }
  
  func remove(_ countryCode: String) {
    objectWillChange.send()
    countryCodes.remove(countryCode)
    save()
  }

  func save() {
    do {
      let fileName = getDocumentsDirectory().appendingPathComponent("SavedCountries")
      let countryIds = Array(self.countryCodes)
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
      countryCodes = Set(countryIds)
    } catch {
      print("Unable to load saved data.")
    }
  }
  
  func toggle(_ countryCode: String) {
    if self.contains(countryCode) {
      self.remove(countryCode)
    } else {
      self.add(countryCode)
    }
  }
}
