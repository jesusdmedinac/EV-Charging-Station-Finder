import Foundation

class GetCurrentLocationUseCaseImpl: GetCurrentLocationUseCase {
  private let locationRepository: LocationRepository

  init(locationRepository: LocationRepository) {
    self.locationRepository = locationRepository
  }

  func execute() async throws -> DomainLatLong {    
    do {
      let hasPermissions = try await locationRepository.hasPermissions()
      if !hasPermissions {
        let requestedPermissions = try await locationRepository.requestPermissions()
        if !requestedPermissions {
          throw DomainError.locationAccessDenied
        }
      }
      let location = try await locationRepository.getCurrentLocation()
      return location
    } catch let error as DataError {
      throw DomainError.data(error)
    } catch {
      throw DomainError.unknown(error)
    }
  }
}
