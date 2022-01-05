//
//  DetailView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 5.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct DetailView: View {
  @ObservedObject var networkingManager = CountryService()
  @EnvironmentObject var favorites: Favorites
  
  @State var countryDetails: CountryDetail?
  
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
    }
    .navigationTitle(countryDetails?.data.name ?? "")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      Button{
        if favorites.contains(countryCode) {
          favorites.remove(countryCode)
        } else {
          favorites.add(countryCode)
        }
      } label: {
        Image(systemName: favorites.contains(countryCode) ? "star.fill" : "star")
      }
    }.buttonStyle(PlainButtonStyle())
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(countryCode: "US")
  }
}
