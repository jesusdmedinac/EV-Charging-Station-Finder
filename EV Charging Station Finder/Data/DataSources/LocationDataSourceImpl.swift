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
  private var locationContinuation: CheckedContinuation<Result<CLLocationCoordinate2D, Error>, Never>?
  private var authorizationContinuation: CheckedContinuation<Bool, Never>?

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  }

  func requestLocationAuthorization() async -> Bool {
    return await withCheckedContinuation { continuation in
      self.authorizationContinuation = continuation
      locationManager.requestWhenInUseAuthorization()
    }
  }

  func getCurrentLocation() async -> Result<CLLocationCoordinate2D, Error> {
    return await withCheckedContinuation { continuation in
      self.locationContinuation = continuation
      locationManager.startUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    locationContinuation?.resume(returning: .success(location.coordinate))
    locationManager.stopUpdatingLocation()
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationContinuation?.resume(returning: .failure(error))
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .authorizedWhenInUse, .authorizedAlways:
      authorizationContinuation?.resume(returning: true)
    case .denied, .restricted:
      authorizationContinuation?.resume(returning: false)
    case .notDetermined:
      break
    @unknown default:
      authorizationContinuation?.resume(returning: false)
    }
  }
}
