//
//  DomainEVChargingStation.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

struct DomainEVChargingStation : Equatable {
  let id: String
  let name: String
  let address: String
  let location: DomainLatLong?
  let connectorTypes: [DomainConnectorType]
  let accessComments: String

  init(
    id: String = "",
    name: String = "",
    address: String = "",
    location: DomainLatLong? = nil,
    connectorTypes: [DomainConnectorType] = [],
    accessComments: String = ""
  ) {
    self.id = id
    self.name = name
    self.address = address
    self.location = location
    self.connectorTypes = connectorTypes
    self.accessComments = accessComments
  }
}
