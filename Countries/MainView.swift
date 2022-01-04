//
//  ContentView.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CountryListView()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
            FavoritesView()
                 .tabItem{
                     Label("Saved", systemImage: "heart.fill")
                 }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
