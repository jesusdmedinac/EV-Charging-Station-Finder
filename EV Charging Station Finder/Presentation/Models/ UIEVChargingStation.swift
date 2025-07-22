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
  let distance: Double? // in miles
  
  init(name: String = "", address: String = "", location: UILatLong? = nil, connectorTypes: [UIConnectorType] = [], accessComments: String = "", distance: Double? = nil) {
    self.name = name
    self.address = address
    self.location = location
    self.connectorTypes = connectorTypes
    self.accessComments = accessComments
    self.distance = distance
  }
  
  func copy(with distance: Double) -> UIEVChargingStation {
    return UIEVChargingStation(
      name: self.name,
      address: self.address,
      location: self.location,
      connectorTypes: self.connectorTypes,
      accessComments: self.accessComments,
      distance: distance
    )
  }
}
