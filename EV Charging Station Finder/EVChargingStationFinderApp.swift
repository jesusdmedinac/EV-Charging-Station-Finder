//
//  EV_Charging_Station_FinderApp.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 17/07/25.
//

import SwiftUI

@main
struct EVChargingStationFinderApp: App {
  private let container = DIContainer.shared

  var body: some Scene {
    WindowGroup {
      StationsListScreen(
        viewModel: container.resolve(StationsListScreenViewModel.self),
      )
    }
  }
}

