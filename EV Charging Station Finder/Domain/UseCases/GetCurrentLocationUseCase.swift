import Foundation

protocol GetCurrentLocationUseCase {
  func execute() async throws -> DomainLatLong
}
