//
//  StationsListScreen.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import SwiftUI

struct UIEVChargingStation : Identifiable {
  var id: String { name }
  
  let name: String
}

struct StationsListScreen : View {
  private let container = DIContainer.shared
  
  @State private var data: [UIEVChargingStation] = []
  private let evChargingStationsRepository: EVChargingStationsRepository
  
  init() {
    self.evChargingStationsRepository = container.resolve(EVChargingStationsRepository.self)
  }
  
  var body: some View {
    VStack {
      ForEach(data) { item in
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
        let data = try await self.evChargingStationsRepository.fetchStations(latitude: 0.0, longitude: 0.0, distance: 10)
        self.data = data.map({ UIEVChargingStation(name: $0.name) })
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
