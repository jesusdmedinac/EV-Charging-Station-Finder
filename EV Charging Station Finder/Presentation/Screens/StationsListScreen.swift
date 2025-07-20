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
      if viewModel.error != nil {
        ZStack {
          Text("Something went wrong... please pull to refresh to try again.")
        }
      } else {
        ZStack {
          if viewModel.isLoading || viewModel.stations.isEmpty {
            ProgressView()
          } else {
            List(viewModel.stations) { station in
              StationRow(uiEVChargingStation: station)
            }
          }
        }
        .navigationBarTitle("EV Charging Stations")
      }
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

#Preview {
  StationsListScreen()
}

struct StationRow: View {
  let uiEVChargingStation: UIEVChargingStation
  
  @State private var distanceInMiles: String? = ""
  
  var body: some View {
    NavigationLink(destination: StationDetailScreen(uiEVChargingStation: uiEVChargingStation)) {
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
        Spacer()
        HStack {
          Image(systemName: "location")
          Text(distanceInMiles ?? "")
        }
        .foregroundColor(.white)
        .padding(4)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
      }
    }
    .onAppear {
      Task {
        await fetchLocation()
      }
    }
  }
  
  private func fetchLocation() async {
    guard let location = uiEVChargingStation.location else { return }
    let latitude: Double = Double(location.latitude ?? 0)
    let longitude: Double = Double(location.longitude ?? 0)
    let stationLocation = CLLocation(latitude: latitude, longitude: longitude)
    let userLocation = CLLocation(latitude: 34.0286238, longitude: -84.2173394)
    let distance = userLocation.distance(from: stationLocation)
    distanceInMiles = "\(String(describing: Int(round(distance * MathConstants.milesFactor)))) mi"
  }
}

#Preview {
  let uiEVChargingStation = UIEVChargingStation(name: "name", address: "address", location: UILatLong(latitude: 0.0, longitude: 0.0), connectorTypes: [], accessComments: "accessComments")
  StationRow(uiEVChargingStation: uiEVChargingStation)
}
