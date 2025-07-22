import Foundation

protocol LocationRepository {
  func getCurrentLocation() async throws -> DomainLatLong
  func requestAuthorization() async -> Bool
}
