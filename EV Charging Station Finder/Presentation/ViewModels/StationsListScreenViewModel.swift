//
//  StationsListScreenViewModel.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation
import Combine
import CoreLocation

@MainActor
class StationsListScreenViewModel: ObservableObject {
  private let getEVChargingStationsUseCase: GetEVChargingStationsUseCase
  private let uiEVChargingStationMapper: UIEVChargingStationMapper
  
  private let defaultLatitude: Double = 37.774722
  private let defaultLongitude: Double = -122.418236
  private let defaultDistance: Double = 10.0
  
  @Published var stations: [UIEVChargingStation] = []
  @Published var isLoading: Bool = false
  @Published var error: Error? = nil
  
  init(getEVChargingStationsUseCase: GetEVChargingStationsUseCase,
       uiEVChargingStationMapper: UIEVChargingStationMapper) {
    self.getEVChargingStationsUseCase = getEVChargingStationsUseCase
    self.uiEVChargingStationMapper = uiEVChargingStationMapper
  }
  
  func fetchStations() async throws {
    self.isLoading = true
    
    do {
      let stations = try await getEVChargingStationsUseCase.execute(
        latitude: defaultLatitude,
        longitude: defaultLongitude,
        distance: defaultDistance
      )
      self.stations = stations.compactMap { uiEVChargingStationMapper.map($0) }
      self.error = nil
      self.isLoading = false
    } catch {
      self.error = error
      throw error
    }
  }
}
