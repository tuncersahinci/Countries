//
//  FavoritesView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 5.01.2022.
//

import SwiftUI

struct FavoritesView: View {
  
  @EnvironmentObject var favorites: Favorites
  @Binding var countries: Countries?
  
  @State var localFavorites = Set<String>()
  @State var shouldUpdateFavorites: Bool = false
  
  var body: some View {
    VStack{
      if countries?.data == nil {
        ProgressView()
      } else {
        NavigationView {
          if let unWrappedData = countries?.data {
            List(unWrappedData.filter({localFavorites.contains($0.code)})) { country in
              NavigationLink(destination: DetailView(shouldUpdateFavorites: $shouldUpdateFavorites, countryCode: country.code)) {
                HStack {
                  Text(country.name)
                  Spacer()
                  Button {
                    favorites.toggle(country.code)
                    self.localFavorites = favorites.countryCodes
                  } label: {
                    Image(systemName: favorites.contains(country.code) ? "star.fill" : "star")
                  }.buttonStyle(PlainButtonStyle())
                }
              }
            }.listStyle(PlainListStyle())
              .navigationBarTitle("Countries")
          }
        }.onAppear{
          self.localFavorites = favorites.countryCodes
        }.onChange(of: shouldUpdateFavorites) { _ in
          if shouldUpdateFavorites {
            self.localFavorites = favorites.countryCodes
            shouldUpdateFavorites = false
          }
        }
      }
    }
  }
}
