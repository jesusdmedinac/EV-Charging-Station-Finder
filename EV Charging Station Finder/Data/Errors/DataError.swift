//
//  DataError.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

enum DataError: Error, LocalizedError {
  case missingAPIKey
  case invalidURL
  case invalidResponse
  case httpError(Int)
  case decodingError(Error)
  case networkError(Error)
  case invalidNetworkClient
    
  var errorDescription: String? {
    switch self {
    case .missingAPIKey:
      return "Open Charge Map API key is missing from Info.plist"
    case .invalidURL:
      return "The provided URL is invalid"
    case .invalidResponse:
      return "Received an invalid response from the server"
    case .httpError(let statusCode):
      return "Server returned HTTP \(statusCode) error"
    case .decodingError(let error):
      return "Failed to decode response: \(error.localizedDescription)"
    case .networkError(let error):
      return "Network error occurred: \(error.localizedDescription)"
    case .invalidNetworkClient:
      return "Invalid NetworkClient instance"
    }
  }
}
