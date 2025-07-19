//
//  StationsListScreen.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import SwiftUI
import CoreLocation
import MapKit

struct StationsListScreen: View {
  private static let container = DIContainer.shared

  @StateObject private var viewModel: StationsListScreenViewModel = {
    return container.resolve(StationsListScreenViewModel.self)
  }()
    
  var body: some View {
    NavigationView {
      List(viewModel.stations) { station in
        NavigationLink(destination: StationDetailScreen()) {
          Text(station.name)
        }
      }
      .navigationBarTitle("EV Charging Stations")
    }
    .onAppear {
      Task {
        await refreshData()
      }
    }
  }
    
  private func refreshData() async {
    do {
      try await viewModel.fetchStations()
    } catch {
      print("\(error)")
    }
  }
}
