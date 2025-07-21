import Foundation

protocol LocationRepository {
    func getCurrentLocation() -> AsyncStream<Result<DomainLatLong, DomainError>>
    func requestAuthorization()
}