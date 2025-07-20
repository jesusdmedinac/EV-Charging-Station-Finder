//
//  EVChargingStationMapper.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

class EVChargingStationMapper {
  /// Maps a `Connection` to a `DomainConnectorType`
  /// - Parameter connection: The `Connection` to be mapped
  /// - Returns: An optional `DomainConnectorType` if the mapping is successful, otherwise nil
  func map(_ connection: Connection?) -> DomainConnectorType? {
    guard let connection else { return nil }
    guard let type = connection.connectionType,
        let typeName = type.title else {
      return nil
    }
    return DomainConnectorType(id: type.id?.description ?? "", name: typeName)
  }
  
  /// Maps an `AddressInfo` to a `DomainLatLong`
  /// - Parameter addressInfo: The `AddressInfo` to be mapped
  /// - Returns: An optional `DomainLatLong` if the mapping is successful, otherwise nil
  func map(_ addressInfo: AddressInfo?) -> DomainLatLong? {
    guard let addressInfo else { return nil }
    let latitude = addressInfo.latitude ?? 0.0
    let longitude = addressInfo.longitude ?? 0.0
    return DomainLatLong(
      latitude: latitude,
      longitude: longitude
    )
  }
  
  /// Maps a `POIResponse` to a `DomainEVChargingStation`
  /// - Parameter poi: The `POIResponse` to be mapped
  /// - Returns: An optional `DomainEVChargingStation` if the mapping is successful, otherwise nil
  func map(_ poi: POIResponse) -> DomainEVChargingStation? {
    guard let id = poi.id?.description,
        let name = poi.addressInfo?.title,
        let address = poi.addressInfo?.addressLine1 else {
      return nil
    }
    
    let accessComments = poi.addressInfo?.accessComments ?? "No comments"
    
    return DomainEVChargingStation(
      id: id,
      name: name,
      address: address,
      location: map(poi.addressInfo),
      connectorTypes: poi.connections?.compactMap { map($0) } ?? [],
      accessComments: accessComments
    )
  }
  
  /// Maps an array of `POIResponse` to an array of `DomainEVChargingStation`
  /// - Parameter poiResponses: The array of `POIResponse` to be mapped
  /// - Returns: An array of `DomainEVChargingStation`
  func map(_ poiResponses: [POIResponse]) -> [DomainEVChargingStation] {
    return poiResponses.compactMap { map($0) }
  }
}
