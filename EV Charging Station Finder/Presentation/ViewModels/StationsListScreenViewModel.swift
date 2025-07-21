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
  private let getCurrentLocationUseCase: GetCurrentLocationUseCase
  
  private let defaultDistance: Double = 10.0
  
  @Published var stations: [UIEVChargingStation] = []
  @Published var isLoading: Bool = false
  @Published var error: PresentationError? = nil
  
  init(getEVChargingStationsUseCase: GetEVChargingStationsUseCase,
       uiEVChargingStationMapper: UIEVChargingStationMapper,
       getCurrentLocationUseCase: GetCurrentLocationUseCase) {
    self.getEVChargingStationsUseCase = getEVChargingStationsUseCase
    self.uiEVChargingStationMapper = uiEVChargingStationMapper
    self.getCurrentLocationUseCase = getCurrentLocationUseCase
  }
  
  private func setupLocationUpdates() async throws -> UILatLong {
    getCurrentLocationUseCase.requestAuthorization()
    
    for await result in getCurrentLocationUseCase.execute() {
      switch result {
      case .success(let domainLatLong):
        self.error = nil
        return UILatLong(latitude: domainLatLong.latitude, longitude: domainLatLong.longitude)
      case .failure(_):
        throw PresentationError.locationNotAvailable
      }
    }
    throw PresentationError.unknown(NSError(domain: "Unable to get current location", code: 1))
  }
  
  func fetchStations() async throws {
    self.isLoading = true
    
    do {
      let location = try await setupLocationUpdates()
      guard let latitude = location.latitude,
      let longitude = location.longitude else {
        throw PresentationError.locationNotAvailable
      }
      let stations = try await getEVChargingStationsUseCase.execute(
        latitude: latitude,
        longitude: longitude,
        distance: defaultDistance
      )
      self.stations = stations.compactMap { uiEVChargingStationMapper.map($0) }
      self.error = nil
    } catch let error as PresentationError {
      self.error = error
    } catch {
      self.error = .unknown(error)
    }
    
    self.isLoading = false
  }
}

