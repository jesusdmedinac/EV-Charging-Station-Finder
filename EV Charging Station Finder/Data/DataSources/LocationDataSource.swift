//
//  LocationDataSource.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import CoreLocation

protocol LocationDataSource {
  func hasPermissions() async throws -> Result<Bool, Error>
  func requestPermissions() async throws -> Result<Bool, Error>
  func getCurrentLocation() async throws -> Result<CLLocation, Error>
}

enum LocationError: Error {
  case authorizationDenied
  case unknown
}
