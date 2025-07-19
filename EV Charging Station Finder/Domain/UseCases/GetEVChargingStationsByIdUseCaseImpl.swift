//
//  GetEVChargingStationsByIdUseCaseImpl.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

class GetEVChargingStationsByIdUseCaseImpl: GetEVChargingStationsByIdUseCase {
  private let repository: EVChargingStationsRepository
  
  init(repository: EVChargingStationsRepository) {
    self.repository = repository
  }
  
  func execute(id: String) async throws -> DomainEVChargingStation {
    guard let station = try await repository.fetchStation(id: id) else {
      throw UseCaseError.notFound
    }
    return station
  }
}
