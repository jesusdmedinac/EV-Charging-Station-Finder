//
//  UILatLong.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 19/07/25.
//

import Foundation

struct UILatLong : Equatable {
  let latitude: Double?
  let longitude: Double?
  
  init(latitude: Double?, longitude: Double?) {
    self.latitude = latitude
    self.longitude = longitude
  }
}
