//
//  UIEVChargingStation.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

struct UIEVChargingStation : Identifiable, Equatable {
  var id: String { name }
  
  let name: String
  let address: String
  let location: UILatLong?
  let connectorTypes: [UIConnectorType]
  let accessComments: String
  
  init(name: String = "", address: String = "", location: UILatLong? = nil, connectorTypes: [UIConnectorType] = [], accessComments: String = "") {
    self.name = name
    self.address = address
    self.location = location
    self.connectorTypes = connectorTypes
    self.accessComments = accessComments
  }
}
