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
  
  init(
    evChargingStationsLocalDataSource: EVChargingStationsLocalDataSource,
    evChargingStationsRemoteDataSource: EVChargingStationsRemoteDataSource
  ) {
    self.evChargingStationsLocalDataSource = evChargingStationsLocalDataSource
    self.evChargingStationsRemoteDataSource = evChargingStationsRemoteDataSource
  }
    
  func fetchStations(
    latitude: Double,
    longitude: Double,
    distance: Double
  ) async throws -> [EVChargingStation] {
    let localStations = evChargingStationsLocalDataSource.fetchEVChargingStations()
    
    if !localStations.isEmpty {
      return localStations
    }
        
    do {
      let poiResponses = try await evChargingStationsRemoteDataSource.fetchEVChargingStations(
        latitude: latitude,
        longitude: longitude,
        distance: distance
      )
            
      let stations = poiResponses.compactMap { poi -> EVChargingStation? in
        guard let id = poi.id?.description,
          let name = poi.addressInfo?.title,
          let address = poi.addressInfo?.addressLine1,
          let latitude = poi.addressInfo?.latitude,
          let longitude = poi.addressInfo?.longitude else {
          return nil
        }
                
        let connectorTypes = poi.connections?.compactMap { connection -> ConnectorType? in
          guard let type = connection.connectionType,
            let typeName = type.title else {
            return nil
          }
          return ConnectorType(id: type.id?.description ?? "", name: typeName)
        } ?? []
                
        return EVChargingStation(
          id: id,
          name: name,
          address: address,
          location: LatLong(latitude: latitude, longitude: longitude),
          connectorTypes: connectorTypes,
          accessComments: poi.usageCost ?? ""
        )
      }
            
      saveStations(stations)
            
      return stations
    } catch {
      if !localStations.isEmpty {
        return localStations
      }
      throw error
    }
  }
    
  func removeAllStations() {
    evChargingStationsLocalDataSource.clearEVChargingStations()
  }
    
  func saveStations(_ stations: [EVChargingStation]) {
    evChargingStationsLocalDataSource.saveEVChargingStations(stations)
  }
}
