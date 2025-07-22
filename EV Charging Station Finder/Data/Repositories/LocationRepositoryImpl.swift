import Foundation
import CoreLocation

class LocationRepositoryImpl: LocationRepository {
  private let locationDataSource: LocationDataSource

  init(locationDataSource: LocationDataSource) {
    self.locationDataSource = locationDataSource
  }

  func hasPermissions() async throws -> Bool {
    let result = try await locationDataSource.hasPermissions()
    switch result {
    case .success(let hasPermissions):
      return hasPermissions
    case .failure(let error):
      if let locationError = error as? LocationError {
        switch locationError {
        case .authorizationDenied:
          throw DomainError.locationAccessDenied
        case .unknown:
          throw DomainError.unknown(error)
        }
      } else {
        throw DomainError.unknown(error)
      }
    }
  }

  func requestPermissions() async throws -> Bool {
    let result = try await locationDataSource.requestPermissions()
    switch result {
    case .success(let hasPermissions):
      return hasPermissions
    case .failure(let error):
      if let locationError = error as? LocationError {
        switch locationError {
        case .authorizationDenied:
          throw DomainError.locationAccessDenied
        case .unknown:
          throw DomainError.unknown(error)
        }
      } else {
        throw DomainError.unknown(error)
      }
    }
  }

  func getCurrentLocation() async throws -> DomainLatLong {
    let result = try await locationDataSource.getCurrentLocation()
    switch result {
    case .success(let location):
      let coordinate = location.coordinate
      return DomainLatLong(latitude: coordinate.latitude, longitude: coordinate.longitude)
    case .failure(let error):
      if let locationError = error as? LocationError {
        switch locationError {
        case .authorizationDenied:
          throw DomainError.locationAccessDenied
        case .unknown:
          throw DomainError.unknown(error)
        }
      } else {
        throw DomainError.unknown(error)
      }
    }
  }
}
