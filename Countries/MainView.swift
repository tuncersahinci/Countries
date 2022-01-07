//
//  ContentView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//

import SwiftUI

struct MainView: View {
  @State var countries: Countries?
  @ObservedObject var favorites = Favorites()
  
  var body: some View {
    TabView {
      CountryListView(countries: $countries)
        .tabItem{
          Label("Home", systemImage: "house.fill")
        }
      FavoritesView(countries: $countries)
        .tabItem{
          Label("Saved", systemImage: "heart.fill")
      }
    }.onAppear{
      CountryService().fetchCountries { (countries ) in
        self.countries = countries
      }
    }.environmentObject(favorites)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
      .preferredColorScheme(.dark)
  }
}
