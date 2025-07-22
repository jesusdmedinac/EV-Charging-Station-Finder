import Foundation

class GetCurrentLocationUseCaseImpl: GetCurrentLocationUseCase {
  private let locationRepository: LocationRepository

  init(locationRepository: LocationRepository) {
    self.locationRepository = locationRepository
  }

  func execute() async throws -> DomainLatLong {
    return try await locationRepository.getCurrentLocation()
  }
  
  func requestAuthorization() async -> Bool {
    return await locationRepository.requestAuthorization()
  }
}
