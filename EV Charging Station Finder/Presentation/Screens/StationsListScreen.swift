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
            Text(error.errorDescription ?? "An unknown error occurred.")
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
