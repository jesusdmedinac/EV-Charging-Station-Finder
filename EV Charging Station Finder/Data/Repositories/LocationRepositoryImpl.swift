import Foundation
import CoreLocation

class LocationRepositoryImpl: LocationRepository {
  private let locationDataSource: LocationDataSource

  init(locationDataSource: LocationDataSource) {
    self.locationDataSource = locationDataSource
  }

  func getCurrentLocation() -> AsyncStream<Result<DomainLatLong, DomainError>> {
    return AsyncStream { continuation in
      Task {
        for await result in locationDataSource.startUpdatingLocation() {
          switch result {
          case .success(let coordinate):
            let domainLatLong = DomainLatLong(latitude: coordinate.latitude, longitude: coordinate.longitude)
            continuation.yield(.success(domainLatLong))
          case .failure(let error):
            if let locationError = error as? LocationError {
                switch locationError {
                case .authorizationDenied:
                  continuation.yield(.failure(.locationAccessDenied))
                case .unknown:
                  continuation.yield(.failure(.unknown(error)))
                }
            } else {
              continuation.yield(.failure(.unknown(error)))
            }
            continuation.finish()
            return
          }
        }
      }
    }
  }
  
  func requestAuthorization() {
    locationDataSource.requestLocationAuthorization()
  }
}
