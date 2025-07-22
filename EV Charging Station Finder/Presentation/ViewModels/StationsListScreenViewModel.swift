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
  @Published var userUILatLong: UILatLong?
  @Published var isLoading: Bool = false
  @Published var error: PresentationError? = nil
  @Published var showLocationDeniedAlert = false
  
  init(getEVChargingStationsUseCase: GetEVChargingStationsUseCase,
       uiEVChargingStationMapper: UIEVChargingStationMapper,
       getCurrentLocationUseCase: GetCurrentLocationUseCase) {
    self.getEVChargingStationsUseCase = getEVChargingStationsUseCase
    self.uiEVChargingStationMapper = uiEVChargingStationMapper
    self.getCurrentLocationUseCase = getCurrentLocationUseCase
  }
  
  func openSettings() {
    self.showLocationDeniedAlert = true
  }
  
  func fetchStations() async {
    self.isLoading = true
    
    do {
      let location = try await getCurrentLocationUseCase.execute()
      self.userUILatLong = UILatLong(latitude: location.latitude, longitude: location.longitude)
      let stations = try await getEVChargingStationsUseCase.execute(
        latitude: location.latitude,
        longitude: location.longitude,
        distance: defaultDistance
      )
      self.stations = stations.compactMap { uiEVChargingStationMapper.map($0) }
      calculateDistance()
      self.error = nil
    } catch let error as PresentationError {
      self.error = error
    } catch let error as DomainError {
      self.error = .domain(error)
    } catch {
      self.error = .unknown(error)
    }
    
    self.isLoading = false
  }

  private func calculateDistance() {
    guard let userUILatLong = self.userUILatLong else { return }
    guard let latitude = userUILatLong.latitude, let longitude = userUILatLong.longitude else { return }
    let userLocation = CLLocation(latitude: latitude, longitude: longitude)
    self.stations = stations.map { station in
      guard let stationLatitude = station.location?.latitude, let stationLongitude = station.location?.longitude else { return station }
      let stationLocation = CLLocation(latitude: stationLatitude, longitude: stationLongitude)
      let distance = userLocation.distance(from: stationLocation)
      return station.copy(with: distance * MathConstants.milesFactor)
    }
  }
}

