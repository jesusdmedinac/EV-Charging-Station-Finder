//
//  StationDetailScreen.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import SwiftUI
import MapKit

struct StationDetailScreen: View {
  @StateObject var viewModel: StationDetailScreenViewModel

  let uiEVChargingStationId: String
    
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text(viewModel.station?.name ?? "")
            .font(.system(size: 31, weight: .bold))
          Spacer()
        }
        HStack {
          Text(viewModel.station?.address ?? "")
            .font(.system(size: 16))
          Spacer()
        }
        HStack {
          Text(viewModel.station?.accessComments ?? "No comments")
            .font(.system(size: 16))
          Spacer()
        }
        HStack {
          ForEach(viewModel.station?.connectorTypes ?? [], id: \ .id) { connectorType in
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
      
      MapView(
        coordinate: $viewModel.mapCenter,
        span: $viewModel.mapSpan,
        annotations: viewModel.mapAnnotations
      )
      .edgesIgnoringSafeArea(.all)
    }
    .onAppear {
      Task {
        await viewModel.fetchStationById(id: uiEVChargingStationId)
      }
    }
  }
}
