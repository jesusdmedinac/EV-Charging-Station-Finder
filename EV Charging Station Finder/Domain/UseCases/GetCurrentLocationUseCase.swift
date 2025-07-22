import Foundation

protocol GetCurrentLocationUseCase {
  func execute() async throws -> DomainLatLong
  func requestAuthorization() async -> Bool
}
