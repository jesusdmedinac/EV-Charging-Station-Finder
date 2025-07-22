//
//  StationsListScreenViewModel.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation
import Combine
import CoreLocation
import MapKit

@MainActor
class StationDetailScreenViewModel: ObservableObject {
  let getEVChargingStationsByIdUseCase: GetEVChargingStationsByIdUseCase
  let uiEVChargingStationMapper: UIEVChargingStationMapper

  @Published var station: UIEVChargingStation?
  @Published var isLoading: Bool = false
  @Published var error: PresentationError? = nil

  @Published var mapCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
  @Published var mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  @Published var mapAnnotations: [MKPointAnnotation] = { return [] }()

  init(getEVChargingStationsByIdUseCase: GetEVChargingStationsByIdUseCase,
       uiEVChargingStationMapper: UIEVChargingStationMapper) {
    self.getEVChargingStationsByIdUseCase = getEVChargingStationsByIdUseCase
    self.uiEVChargingStationMapper = uiEVChargingStationMapper
  }

  func fetchStationById(id: String) async {
    self.isLoading = true
    
    do {
      let station = try await getEVChargingStationsByIdUseCase.execute(id: id)
      self.station = uiEVChargingStationMapper.map(station)
      self.error = nil
      updateMapRegion()
    } catch let error as PresentationError {
      self.error = error
    } catch let error as DomainError {
      self.error = .domain(error)
    } catch {
      self.error = .unknown(error)
    }
    
    self.isLoading = false
  }

  private func updateMapRegion() {
    guard let station = station else { return }
    let title = station.name
    let subtitle = station.address
    guard let location = station.location else { return }
    guard let latitude = location.latitude, let longitude = location.longitude else { return }
    mapCenter = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let annotation = MKPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    annotation.title = title
    annotation.subtitle = subtitle
    mapAnnotations = [annotation]
  }
}

