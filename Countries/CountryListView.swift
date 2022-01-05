//
//  CountryListView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject var networkingManager = CountryService()
    @ObservedObject var favorites = Favorites()
    
    @State var countries: Countries?
    
    var body: some View {
        NavigationView {
            if let unWrappedData = countries?.data {
                List(unWrappedData) { country in
                    NavigationLink(destination: DetailView(countryCode: country.code))
                    {
                    HStack {
                        Text(country.name)
                        Spacer()
                        Button {
                            if favorites.contains(country.code) {
                                favorites.remove(country.code)
                                } else {
                                    favorites.add(country.code)
                                }
                            } label: {
                                Image(systemName: favorites.contains(country.code) ? "star.fill" : "star")
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }.navigationBarTitle("Countries")
        .onAppear{
            CountryService().fetchCountries { (countries ) in
                self.countries = countries
            }
        }.environmentObject(favorites)
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
