//
//  InformationView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 5.01.2022.
//

import SwiftUI

struct InformationView: View {
    
    @ObservedObject var networkingManager = CountryService()
    
    let countryCode: String
    
    var body: some View {
        HStack {
            if let unwrappedDetail = networkingManager.countryDetail {
                UrlWebView(urlToDisplay: URL(string: "https://www.wikidata.org/wiki/\(unwrappedDetail.wikiDataID)")!)
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(countryCode: "US")
    }
}
