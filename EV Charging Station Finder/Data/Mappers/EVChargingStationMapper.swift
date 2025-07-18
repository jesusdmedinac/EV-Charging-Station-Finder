//
//  EVChargingStationMapper.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

class EVChargingStationMapper {
  /// Maps a `POIResponse` to an `EVChargingStation`
  /// - Parameter poi: The `POIResponse` to be mapped
  /// - Returns: An optional `EVChargingStation` if the mapping is successful, otherwise nil
  func map(_ poi: POIResponse) -> EVChargingStation? {
    guard let id = poi.id?.description,
        let name = poi.addressInfo?.title,
        let address = poi.addressInfo?.addressLine1,
        let latitude = poi.addressInfo?.latitude,
        let longitude = poi.addressInfo?.longitude else {
      return nil
    }
    
    let connectorTypes = poi.connections?.compactMap { connection -> ConnectorType? in
      guard let type = connection.connectionType,
          let typeName = type.title else {
        return nil
      }
      return ConnectorType(id: type.id?.description ?? "", name: typeName)
    } ?? []
    
    return EVChargingStation(
      id: id,
      name: name,
      address: address,
      location: LatLong(latitude: latitude, longitude: longitude),
      connectorTypes: connectorTypes,
      accessComments: poi.usageCost ?? ""
    )
  }
  
  /// Maps an array of `POIResponse` to an array of `EVChargingStation`
  /// - Parameter poiResponses: The array of `POIResponse` to be mapped
  /// - Returns: An array of `EVChargingStation`
  func map(_ poiResponses: [POIResponse]) -> [EVChargingStation] {
    return poiResponses.compactMap { map($0) }
  }
}
