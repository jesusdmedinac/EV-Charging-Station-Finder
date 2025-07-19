//
//  UIEVChargingStation.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

struct UIEVChargingStation : Identifiable {
  var id: String { name }
  
  let name: String
  let address: String
  let location: UILatLong?
  let connectorTypes: [UIConnectorType]
  let accessComments: String
}
