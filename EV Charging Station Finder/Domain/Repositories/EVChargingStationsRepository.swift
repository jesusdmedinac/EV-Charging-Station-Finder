//
//  EVChargingStationsRepository.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

protocol EVChargingStationsRepository {
  // Fetches a list of EV charging stations near the specified location
  // - Parameters:
  //   - latitude: The latitude coordinate of the center point
  //   - longitude: The longitude coordinate of the center point
  //   - distance: The max distance from the given latitude and longitude
  // - Returns: An array of `EVChargingStation` objects
  // - Throws: An error if the request fails
  func fetchStations(
    latitude: Double,
    longitude: Double,
    distance: Double
  ) async throws -> [EVChargingStation]
  
  // Removes all EV charging stations from the repository
  func removeAllStations()
  
  // Saves an array of EV charging stations to the repository
  // - Parameter stations: Array of `EVChargingStation` objects to save
  func saveStations(_ stations: [EVChargingStation])
}
