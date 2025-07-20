//
//  LocationDataSourceImpl.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Foundation
import CoreLocation

class LocationDataSourceImpl: NSObject, LocationDataSource, CLLocationManagerDelegate {
  private let locationManager = CLLocationManager()
  private var continuation: AsyncStream<Result<CLLocationCoordinate2D, Error>>.Continuation?

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  }

  func requestLocationAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }

  func startUpdatingLocation() -> AsyncStream<Result<CLLocationCoordinate2D, Error>> {
    return AsyncStream {
      self.continuation = $0
      locationManager.startUpdatingLocation()
    }
  }

  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
    continuation?.finish()
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    continuation?.yield(.success(location.coordinate))
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    continuation?.yield(.failure(error))
    continuation?.finish()
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .authorizedWhenInUse, .authorizedAlways:
      break
    case .denied, .restricted:
      continuation?.yield(.failure(LocationError.authorizationDenied))
      continuation?.finish()
    case .notDetermined:
      break
    @unknown default:
      break
    }
  }
}
