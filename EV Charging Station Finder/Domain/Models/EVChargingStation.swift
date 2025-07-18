//
//  EVChargingStation.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

struct EVChargingStation {
  let id: String
  let name: String
  let address: String
  let location: LatLong
  let connectorTypes: [ConnectorType]
  let accessComments: String
}
