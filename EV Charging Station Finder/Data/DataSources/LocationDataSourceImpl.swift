//
//  LocationDataSourceImpl.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Foundation
import CoreLocation

actor LocationState {
  private var locationContinuation: CheckedContinuation<Result<CLLocation, any Error>, Never>?
  private var authorizationContinuation: CheckedContinuation<Result<Bool, any Error>, Never>?
  
  func setLocationContinuation(_ continuation: CheckedContinuation<Result<CLLocation, any Error>, Never>?) {
    self.locationContinuation = continuation
  }
  
  func setAuthorizationContinuation(_ continuation: CheckedContinuation<Result<Bool, any Error>, Never>?) {
    self.authorizationContinuation = continuation
  }
  
  func resolveLocation(_ result: Result<CLLocation, any Error>) {
    locationContinuation?.resume(returning: result)
    locationContinuation = nil
  }
  
  func resolveAuthorization(_ result: Result<Bool, any Error>) {
    authorizationContinuation?.resume(returning: result)
    authorizationContinuation = nil
  }
}

class LocationDataSourceImpl: NSObject, LocationDataSource, CLLocationManagerDelegate {
  private let locationManager: CLLocationManager
  private let state = LocationState()
  
  override init() {
    self.locationManager = CLLocationManager()
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  }
  
  func hasPermissions() async throws -> Result<Bool, Error> {
    let status = locationManager.authorizationStatus
    if status == .notDetermined {
      return await requestPermissions()
    }
    return .success(status == .authorizedWhenInUse || status == .authorizedAlways)
  }
  
  func requestPermissions() async -> Result<Bool, Error> {
    let status = locationManager.authorizationStatus
    if status != .notDetermined {
      return .success(status == .authorizedWhenInUse || status == .authorizedAlways)
    }
    
    return await withCheckedContinuation { continuation in
      Task {
        await state.setAuthorizationContinuation(continuation)
        DispatchQueue.main.async { [weak self] in
          self?.locationManager.requestWhenInUseAuthorization()
        }
      }
    }
  }
  
  func getCurrentLocation() async throws -> Result<CLLocation, any Error> {
    let authStatus = locationManager.authorizationStatus
    guard authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways else {
      return .failure(NSError(domain: "LocationError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Location access not authorized"]))
    }
    
    return await withCheckedContinuation { continuation in
      Task {
        await state.setLocationContinuation(continuation)
        DispatchQueue.main.async { [weak self] in
          self?.locationManager.startUpdatingLocation()
        }
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    locationManager.stopUpdatingLocation()
    Task {
      await state.resolveLocation(.success(location))
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
    Task {
      await state.resolveLocation(.failure(error))
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    Task {
      switch manager.authorizationStatus {
      case .authorizedWhenInUse, .authorizedAlways:
        await state.resolveAuthorization(.success(true))
      case .denied, .restricted:
        await state.resolveAuthorization(.success(false))
      case .notDetermined:
        break
      @unknown default:
        await state.resolveAuthorization(.success(false))
      }
    }
  }
}

