//
//  GetEVChargingStationsUseCase.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

protocol GetEVChargingStationsUseCase {
  /// Fetches a list of EV charging stations near the specified location.
  ///
  /// - Parameters:
  ///   - latitude: The latitude coordinate of the center point.
  ///   - longitude: The longitude coordinate of the center point.
  ///   - distance: The max distance from the given latitude and longitude.
  /// - Returns: An array of `EVChargingStation` objects.
  /// - Throws: An error if the request fails.
  func execute(latitude: Double, longitude: Double, distance: Double) async throws -> [DomainEVChargingStation]
}
