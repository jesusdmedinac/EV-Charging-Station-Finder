import Foundation
import CoreLocation

class LocationRepositoryImpl: LocationRepository {
  private let locationDataSource: LocationDataSource

  init(locationDataSource: LocationDataSource) {
    self.locationDataSource = locationDataSource
  }

  func getCurrentLocation() async throws -> DomainLatLong {
    let result = await locationDataSource.getCurrentLocation()
    switch result {
    case .success(let coordinate):
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
  
  func requestAuthorization() async -> Bool {
    return await locationDataSource.requestLocationAuthorization()
  }
}
