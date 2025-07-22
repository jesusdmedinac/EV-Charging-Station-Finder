import Foundation

protocol LocationRepository {
  func hasPermissions() async throws -> Bool
  func requestPermissions() async throws -> Bool
  func getCurrentLocation() async throws -> DomainLatLong
}
