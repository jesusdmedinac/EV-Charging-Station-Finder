import Foundation

enum UseCaseError: Error, LocalizedError {
  case notFound
  case unknown
  
  var errorDescription: String? {
    switch self {
    case .notFound:
      return "The requested resource was not found"
    case .unknown:
      return "An unknown error occurred"
    }
  }
}