//
//  DomainError.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Foundation

enum DomainError: Error, LocalizedError {
  case data(DataError)
  case notFound
  case locationAccessDenied
  case unknown(Error)
  
  var errorDescription: String {
    switch self {
    case .data(let error):
      return error.errorDescription
    case .notFound:
      return "The requested resource was not found"
    case .locationAccessDenied:
      return "Location access was denied by the user."
    case .unknown(let error):
      return "An unknown DomainError occurred: \(error)"
    }
  }
}
