//
//  PresentationErrors.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Foundation

enum PresentationError: Error, LocalizedError {
  case domain(DomainError)
  case locationNotAvailable
  case unknown(Error)
  
  var errorDescription: String {
    switch self {
    case .domain(let error):
      return error.errorDescription
    case .locationNotAvailable:
      return "Location not available"
    case .unknown(let error):
      return "An unknown error occurred: \(error)"
    }
  }
}
