//
//  CountryListView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//

import SwiftUI

struct CountryListView: View {
  
  @EnvironmentObject var favorites: Favorites
  @Binding var countries: Countries?
  
  var body: some View {
    VStack{
      if countries?.data == nil {
        ProgressView()
      } else {
        NavigationView {
          if let unWrappedData = countries?.data {
            List(unWrappedData) { country in
              NavigationLink(destination: DetailView(countryCode: country.code)) {
                HStack {
                  Text(country.name)
                  Spacer()
                  Button {
                    favorites.toggle(country.code)
                  } label: {
                    Image(systemName: favorites.contains(country.code) ? "star.fill" : "star")
                  }.buttonStyle(PlainButtonStyle())
                }
              }
            }.listStyle(PlainListStyle())
              .navigationBarTitle("Countries")
          }
        }
      }
    }
  }
}
