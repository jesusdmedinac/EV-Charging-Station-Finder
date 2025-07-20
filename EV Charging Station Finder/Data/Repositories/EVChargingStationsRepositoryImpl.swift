//
//  EVChargingStationsRepositoryImpl.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

class EVChargingStationsRepositoryImpl: EVChargingStationsRepository {
  private let evChargingStationsLocalDataSource: EVChargingStationsLocalDataSource
  private let evChargingStationsRemoteDataSource: EVChargingStationsRemoteDataSource
  private let evChargingStationMapper: EVChargingStationMapper
  
  init(
    evChargingStationsLocalDataSource: EVChargingStationsLocalDataSource,
    evChargingStationsRemoteDataSource: EVChargingStationsRemoteDataSource,
    evChargingStationMapper: EVChargingStationMapper
  ) {
    self.evChargingStationsLocalDataSource = evChargingStationsLocalDataSource
    self.evChargingStationsRemoteDataSource = evChargingStationsRemoteDataSource
    self.evChargingStationMapper = evChargingStationMapper
  }
    
  func fetchStations(
    latitude: Double,
    longitude: Double,
    distance: Double
  ) async throws -> [DomainEVChargingStation] {
    do {
      let localStations = try evChargingStationsLocalDataSource.fetchEVChargingStations()
      
      if !localStations.isEmpty {
        return localStations
      }
        
      let poiResponses = try await evChargingStationsRemoteDataSource.fetchEVChargingStations(
        latitude: latitude,
        longitude: longitude,
        distance: distance
      )
      
      let stations = evChargingStationMapper.map(poiResponses)

      saveStations(stations)
            
      return stations
    } catch let error as DataError {
      throw DomainError.data(error)
    } catch {
      throw DomainError.unknown(error)
    }
  }
    
  func removeAllStations() {
    evChargingStationsLocalDataSource.clearEVChargingStations()
  }
    
  func saveStations(_ stations: [DomainEVChargingStation]) {
    evChargingStationsLocalDataSource.saveEVChargingStations(stations)
  }
  
  func fetchStation(id: String) async throws -> DomainEVChargingStation? {
    evChargingStationsLocalDataSource.getEVChargingStation(id: id)
  }
}
