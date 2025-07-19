//
//  StationDetailScreen.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import SwiftUI
import MapKit

struct StationDetailScreen: View {
  @State private var mapCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
  @State private var mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  @State private var mapAnnotations: [MKPointAnnotation] = { return [] }()
  
  let uiEVChargingStation: UIEVChargingStation
    
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text(uiEVChargingStation.name)
            .font(.system(size: 31, weight: .bold))
          Spacer()
        }
        HStack {
          Text(uiEVChargingStation.address)
            .font(.system(size: 16))
          Spacer()
        }
        HStack {
          Text(uiEVChargingStation.accessComments)
            .font(.system(size: 16))
          Spacer()
        }
        HStack {
          ForEach(uiEVChargingStation.connectorTypes) { connectorType in
            VStack {
              Text(connectorType.name)
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(8)))
          }
          Spacer()
        }
      }
      .padding()
      
      MapView(coordinate: $mapCenter, span: $mapSpan, annotations: mapAnnotations)
          .edgesIgnoringSafeArea(.all)
    }
    .onAppear {
      updateMapRegion()
    }
  }
  
  private func updateMapRegion() {
    let title = uiEVChargingStation.name
    let subtitle = uiEVChargingStation.address
    guard let location = uiEVChargingStation.location else { return }
    guard let latitude = location.latitude, let longitude = location.longitude else { return }
    mapCenter = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let annotation = MKPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    annotation.title = title
    annotation.subtitle = subtitle
    mapAnnotations = [annotation]
  }
}

#Preview {
  let uiEVChargingStation = UIEVChargingStation(name: "name", address: "address", location: UILatLong(latitude: 0.0, longitude: 0.0), connectorTypes: [UIConnectorType(name: "name")], accessComments: "accessComments")
  StationDetailScreen(uiEVChargingStation: uiEVChargingStation)
}
