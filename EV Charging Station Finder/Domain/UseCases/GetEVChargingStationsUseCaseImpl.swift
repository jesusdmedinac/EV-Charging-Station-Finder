//
//  GetEVChargingStationsUseCaseImpl.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

class GetEVChargingStationsUseCaseImpl: GetEVChargingStationsUseCase {
  private let repository: EVChargingStationsRepository
  
  init(repository: EVChargingStationsRepository) {
    self.repository = repository
  }
  
  func execute(latitude: Double, longitude: Double, distance: Double) async throws -> [EVChargingStation] {
    return try await repository.fetchStations(latitude: latitude, longitude: longitude, distance: distance)
  }
}
