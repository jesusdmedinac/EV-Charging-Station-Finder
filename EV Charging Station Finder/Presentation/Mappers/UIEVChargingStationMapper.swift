//
//  UIEVChargingStationMapper.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

class UIEVChargingStationMapper {
  /// Maps a `EVChargingStation` to an `UIEVChargingStation`
  /// - Parameter evChargingStation: The `EVChargingStation` to be mapped
  /// - Returns: An optional `UIEVChargingStation` if the mapping is successful, otherwise nil
  func map(_ evChargingStation: EVChargingStation) -> UIEVChargingStation? {
    return UIEVChargingStation(
      name: evChargingStation.name,
      address: evChargingStation.address,
      location: evChargingStation.location,
      connectorTypes: evChargingStation.connectorTypes,
      accessComments: evChargingStation.accessComments
    )
  }
  
  /// Maps an array of `EVChargingStation` to an array of `UIEVChargingStation`
  /// - Parameter evChargingStations: The array of `EVChargingStation` to be mapped
  /// - Returns: An array of `UIEVChargingStation`
  func map(_ evChargingStations: [EVChargingStation]) -> [UIEVChargingStation] {
    return evChargingStations.compactMap { map($0) }
  }
}
