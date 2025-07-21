import Foundation

class GetCurrentLocationUseCaseImpl: GetCurrentLocationUseCase {
    private let locationRepository: LocationRepository

    init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }

    func execute() -> AsyncStream<Result<DomainLatLong, DomainError>> {
        return locationRepository.getCurrentLocation()
    }
    
    func requestAuthorization() {
        locationRepository.requestAuthorization()
    }
}