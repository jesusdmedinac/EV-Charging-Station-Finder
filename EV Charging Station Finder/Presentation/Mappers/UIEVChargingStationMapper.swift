//
//  UIEVChargingStationMapper.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

class UIEVChargingStationMapper {
  /// Maps a `ConnectorType` to an `UIConnectorType`
  /// - Parameter connectorType: The `ConnectorType` to be mapped
  /// - Returns: An optional `UIConnectorType` if the mapping is successful, otherwise nil
  func map(_ connectorType: DomainConnectorType) -> UIConnectorType {
    return UIConnectorType(name: connectorType.name)
  }
  
  /// Maps a `DomainLatLong` to an `UILatLong`
  /// - Parameter latLong: The `DomainLatLong` to be mapped
  /// - Returns: An optional `UILatLong` if the mapping is successful, otherwise nil
  func map(_ latLong: DomainLatLong?) -> UILatLong? {
    guard let latLong else { return nil }
    return UILatLong(latitude: latLong.latitude, longitude: latLong.longitude)
  }
  
  /// Maps a `DomainEVChargingStation` to an `UIEVChargingStation`
  /// - Parameter evChargingStation: The `DomainEVChargingStation` to be mapped
  /// - Returns: An optional `UIEVChargingStation` if the mapping is successful, otherwise nil
  func map(_ evChargingStation: DomainEVChargingStation) -> UIEVChargingStation? {
    return UIEVChargingStation(
      name: evChargingStation.name,
      address: evChargingStation.address,
      location: map(evChargingStation.location),
      connectorTypes: evChargingStation.connectorTypes.compactMap { map($0) },
      accessComments: evChargingStation.accessComments
    )
  }
  
  /// Maps an array of `DomainEVChargingStation` to an array of `UIEVChargingStation`
  /// - Parameter evChargingStations: The array of `DomainEVChargingStation` to be mapped
  /// - Returns: An array of `UIEVChargingStation`
  func map(_ evChargingStations: [DomainEVChargingStation]) -> [UIEVChargingStation] {
    return evChargingStations.compactMap { map($0) }
  }
}
