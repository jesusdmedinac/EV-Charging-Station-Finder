//
//  LocationDataSource.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import CoreLocation

protocol LocationDataSource {
  func requestLocationAuthorization() async -> Bool
  func getCurrentLocation() async -> Result<CLLocationCoordinate2D, Error>
}

enum LocationError: Error {
  case authorizationDenied
  case unknown
}
