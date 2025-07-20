//
//  DomainLatLong.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

struct DomainLatLong : Equatable {
  let latitude: Double
  let longitude: Double

  init(
    latitude: Double = 0,
    longitude: Double = 0
  ) {
    self.latitude = latitude
    self.longitude = longitude
  }
}
