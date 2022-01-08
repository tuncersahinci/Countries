//
//  DetailView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 5.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  
  @ObservedObject var networkingManager = CountryService()
  @EnvironmentObject var favorites: Favorites
  @State var countryDetails: CountryDetail?
  var shouldUpdateFavorites: Binding<Bool>?
  let countryCode: String
  
  var body: some View {
    VStack {
      if countryDetails?.data == nil {
        ProgressView()
      } else {
        ScrollView{
          if let unwrappedDetail = countryDetails?.data {
            VStack(spacing: 50) {
              WebImage(url: URL(string: unwrappedDetail.flagImageURI))
                .resizable()
                .scaledToFit()
                .modifier(RoundedEdge(width: 1, color: .black, cornerRadius: 0))
              HStack {
                Text("Country Code:")
                  .fontWeight(.heavy)
                Text(unwrappedDetail.code)
              }
              Link("Click for more information", destination: URL(string: "https://www.wikidata.org/wiki/\(unwrappedDetail.wikiDataID)")!)
                .buttonStyle(RoundedRectangleButtonStyle())
            }
          }
        }
      }
    }
    .onAppear{
      CountryService().fetchCountryDetails( countryCode: countryCode) { (countryDetails) in
        self.countryDetails = countryDetails
      }
    }.onDisappear{
      self.shouldUpdateFavorites?.wrappedValue = true
    }
    .navigationTitle(countryDetails?.data.name ?? "")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      Button{
        favorites.toggle(countryCode)
      } label: {
        Image(systemName: favorites.contains(countryCode) ? "star.fill" : "star")
      }
    }.buttonStyle(PlainButtonStyle())
  }
}

