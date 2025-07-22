//
//  StationsListScreen.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import SwiftUI
import MapKit

struct StationsListScreen: View {
  @StateObject var viewModel: StationsListScreenViewModel

  var body: some View {
    NavigationView {
      ZStack {
        if let error = viewModel.error {
          VStack {
            if case let PresentationError.domain(domainError) = error {
              switch domainError {
              case .locationAccessDenied:
                Text(error.errorDescription)
                Button("Open Settings") {
                  viewModel.openSettings()
                }
                Text("Once permissions are approved, tap Retry.")
              default:
                Text(error.errorDescription)
              }
            }
            Button("Retry") {
              Task {
                await viewModel.fetchStations()
              }
            }
          }
        } else if viewModel.isLoading {
          ProgressView()
        } else {
          List(viewModel.stations) { station in
            NavigationLink(destination: StationDetailScreen(uiEVChargingStation: station)) {
              StationRow(
                uiEVChargingStation: station
              )
            }
          }
          .navigationTitle("EV Charging Stations")
        }
      }
    }
    .onAppear {
      Task {
        await viewModel.fetchStations()
      }
    }
    .alert(isPresented: $viewModel.showLocationDeniedAlert) {
      Alert(
        title: Text("Location Access Required"),
        message: Text("This app needs access to your location to find nearby charging stations. Please enable location access in Settings."),
        primaryButton: .default(Text("Settings")) {
          if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
          }
        },
        secondaryButton: .cancel()
      )
    }
  }
}

struct StationRow: View {
  let uiEVChargingStation: UIEVChargingStation
  
  var body: some View {
    HStack {
      Image(systemName: "ev.charger")
        .font(.system(size: 16))
        .foregroundColor(.white)
        .padding(8)
        .background(Color.green)
        .clipShape(Circle())
      VStack(alignment: .leading) {
        Text(uiEVChargingStation.name)
          .font(.system(size: 14))
        Text(uiEVChargingStation.address)
          .font(.system(size: 12))
      }
    }
  }
}
