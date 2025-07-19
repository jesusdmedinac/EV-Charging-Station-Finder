//
//  StationsListScreen.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation
import SwiftUI

struct StationsListScreen : View {
  private static let container = DIContainer.shared
  
  @StateObject private var stationsListScreenViewModel: StationsListScreenViewModel = {
    return container.resolve(StationsListScreenViewModel.self)
  }()
  
  var body: some View {
    VStack {
      ForEach(stationsListScreenViewModel.stations) { item in
        Text(item.name)
      }
    }
      .onAppear {
        callFetch()
      }
  }
  
  private func callFetch() {
    Task {
      do {
        try stationsListScreenViewModel.fetchStations()
      } catch {
        switch error {
          case EVChargingAPIError.missingAPIKey:
            print("Open Charge Map API key is missing from Info.plist")
          case EVChargingAPIError.invalidURL:
            print("The provided URL is invalid")
          case EVChargingAPIError.invalidResponse:
            print("Received an invalid response from the server")
          case EVChargingAPIError.httpError(let statusCode):
            print("Server returned HTTP \(statusCode) error")
          case EVChargingAPIError.decodingError(let error):
            print("Failed to decode response: \(error.localizedDescription)")
          case EVChargingAPIError.networkError(let error):
            print("Network error occurred: \(error.localizedDescription)")
          default:
            print("Unknown error: \(error)")
        }
      }
    }
  }
}
