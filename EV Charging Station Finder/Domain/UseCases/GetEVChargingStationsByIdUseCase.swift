//
//  GetEVChargingStationsByIdUseCase.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

protocol GetEVChargingStationsByIdUseCase {
  /// Fetches a specific EV charging station by its id.
  ///
  /// - Parameter id: The id of the EV charging station to fetch.
  /// - Returns: The EV charging station with the specified id.
  /// - Throws: An error if the EV charging station with the specified id is not found.
  func execute(id: String) async throws -> DomainEVChargingStation
}
