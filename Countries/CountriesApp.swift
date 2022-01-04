//
//  CountriesApp.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//


import SwiftUI
import SDWebImage
import SDWebImageSVGCoder
@main
struct CountriesApp: App {
    init() {
        setUpDependencies() // Initialize SVGCoder
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
// Initialize SVGCoder
private extension CountriesApp {
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}
