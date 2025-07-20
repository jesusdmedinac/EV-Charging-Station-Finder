//
//  MockEVChargingStationsRepository.swift
//  EV Charging Station FinderTests
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

@testable import EV_Charging_Station_Finder

class MockEVChargingStationsRepository: EVChargingStationsRepository {
  var invokedFetchStationCount = 0
  var invokedFetchStationParameters: (id: String, Void)?
  var stubbedFetchStationResult: DomainEVChargingStation?
  var stubbedFetchStationError: Error?

  var invokedFetchStationsCount = 0
  var invokedFetchStationsParameters: (latitude: Double, longitude: Double, distance: Double)?
  var stubbedFetchStationsResult: [DomainEVChargingStation] = []
  var stubbedFetchStationsError: Error?
  
  func fetchStation(id: String) async throws -> DomainEVChargingStation? {
    invokedFetchStationCount += 1
    invokedFetchStationParameters = (id, ())
    
    if let error = stubbedFetchStationError {
      throw error
    }
    
    return stubbedFetchStationResult
  }
  
  func fetchStations(latitude: Double, longitude: Double, distance: Double) async throws -> [DomainEVChargingStation] {
    invokedFetchStationsCount += 1
    invokedFetchStationsParameters = (latitude, longitude, distance)
    
    if let error = stubbedFetchStationsError {
      throw error
    }
    
    return stubbedFetchStationsResult
  }
  
  func saveStations(_ stations: [DomainEVChargingStation]) {
    fatalError("Not implemented")
  }
  
  func removeAllStations() {
    fatalError("Not implemented")
  }
}
