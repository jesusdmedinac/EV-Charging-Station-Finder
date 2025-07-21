import Foundation

protocol GetCurrentLocationUseCase {
    func execute() -> AsyncStream<Result<DomainLatLong, DomainError>>
    func requestAuthorization()
}