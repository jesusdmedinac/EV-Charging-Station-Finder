//
//  EVChargingStationsAPIService.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

class EVChargingStationsAPIService : EVChargingStationsRemoteDataSource {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }

  func fetchEVChargingStations(latitude: Double, longitude: Double, distance: Double) async throws -> [POIResponse] {
    let baseUrl = OpenChargeMapAPI.baseURL
    guard let openChargeMapKey: String = Bundle.main.infoDictionary?["OPEN_CHARGE_MAP_KEY"] as? String else {
      throw NSError(domain: "EVChargingStationsAPIService", code: 1, userInfo: nil)
    }
    let stringUrl = "\(baseUrl)?output=json&lat=\(latitude)&lon=\(longitude)&distance=\(distance)&key=\(openChargeMapKey)"
    let url = URL(string: OpenChargeMapAPI.baseURL)
    
    
    return [POIResponse()]
  }
}

