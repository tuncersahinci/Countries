//
//  CountryListView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject var networkingManager = CountryService()

    var body: some View {
        NavigationView {
            List(networkingManager.countryResults) { country in
                NavigationLink(destination: DetailView(countryCode: country.code))
                    {
                    HStack {
                        Text(country.name)
                        Spacer()
                        Button {
                           
                        } label: {
                            Image(systemName: "star")
                        }
                    }

                }
            }.navigationBarTitle("Countries")
        }
        .onAppear{
            networkingManager.fethcCountries()
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
