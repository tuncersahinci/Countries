//
//  Helpers.swift
//  Countries
//
//  Created by Tuncer Şahinci on 4.01.2022.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    Button(action: {}, label: {
        configuration.label.foregroundColor(.white)
      }
    )
    .allowsHitTesting(false)
    .padding()
    .background(Color.blue.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct Constants {
    static let host = "wft-geo-db.p.rapidapi.com"
    static let apiKey = "0ca672deafmshe578bc0c7bffe3dp1f4b69jsn8d950823a097"
}




