//
//  DomainEVChargingStation.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

struct DomainEVChargingStation {
  let id: String
  let name: String
  let address: String
  let location: DomainLatLong?
  let connectorTypes: [DomainConnectorType]
  let accessComments: String
}
