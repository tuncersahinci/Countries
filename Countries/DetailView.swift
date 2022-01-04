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
    
    let countryCode: String
    
    var body: some View {
        ScrollView{
            if let unwrappedDetail = networkingManager.countryDetail {
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
        }.onAppear{
            networkingManager.fetchCountryDetails(countryCode: countryCode)
        }
        .navigationBarTitle( networkingManager.countryDetail?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        }
    }

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(countryCode: "US")
    }
}
