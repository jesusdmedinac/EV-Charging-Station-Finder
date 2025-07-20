//
//  EVChargingStationsInMemoryDataSourceTests.swift
//  EV Charging Station FinderTests
//
//  Created by Jesus Daniel Medina Cruz on 17/07/25.
//

import Testing
@testable import EV_Charging_Station_Finder

@Suite("EVChargingStationsInMemoryDataSource Tests")
struct EVChargingStationsInMemoryDataSourceTests {
  
  private var evChargingStationsInMemoryDataSource: EVChargingStationsInMemoryDataSource

  init() {
    evChargingStationsInMemoryDataSource = EVChargingStationsInMemoryDataSource()
  }

  private func randomDomainEVChargingStation() -> DomainEVChargingStation {
    let randomID = Int.random(in: 1...100).description
    let randomName = "Station " + randomID
    let randomAddress = "Address " + randomID
    let randomLatitude = Double.random(in: -90...90)
    let randomLongitude = Double.random(in: -180...180)
    return DomainEVChargingStation(
      id: randomID,
      name: randomName,
      address: randomAddress,
      location: DomainLatLong(latitude: randomLatitude, longitude: randomLongitude),
      connectorTypes: [],
      accessComments: "accessComments"
    )
  }

  @Test("fetchEVChargingStations should return an empty array given saveEVChargingStations is never called")
  func fetchEVChargingStationsShouldReturnEmptyArrayGivenSaveEVChargingStationsIsNeverCalled() {
    // When
    let result = evChargingStationsInMemoryDataSource.fetchEVChargingStations()
    
    // Then
    #expect(result.isEmpty, "Result does not match empty array")
  }

  @Test("fetchEVChargingStations should return the expected array given saveEVChargingStations is called with expected array")
  func fetchEVChargingStationsShouldReturnExpectedArrayGivenSaveEVChargingStationsIsCalledWithExpectedArray() {
    // Given
    let expectedArray: [DomainEVChargingStation] = [
      randomDomainEVChargingStation(),
      randomDomainEVChargingStation(),
      randomDomainEVChargingStation()
    ]
    evChargingStationsInMemoryDataSource.saveEVChargingStations(expectedArray)
    
    // When
    let result = evChargingStationsInMemoryDataSource.fetchEVChargingStations()
    
    // Then
    #expect(result == expectedArray, "Result does not match expected array")
  }

  @Test("fetchEVChargingStation should return an empty array given clearEVChargingStations is called")
  func fetchEVChargingStationShouldReturnEmptyArrayGivenClearEVChargingStationsIsCalled() {
    // Given
    let expectedArray: [DomainEVChargingStation] = [
      randomDomainEVChargingStation(),
      randomDomainEVChargingStation(),
      randomDomainEVChargingStation()
    ]
    evChargingStationsInMemoryDataSource.saveEVChargingStations(expectedArray)
    
    // When
    evChargingStationsInMemoryDataSource.clearEVChargingStations()
    let result = evChargingStationsInMemoryDataSource.fetchEVChargingStations()
    
    // Then
    #expect(result.isEmpty, "Result does not match expected array")
  }

  @Test("getEVChargingStation should return the expected object given saveEVChargingStation is called with expected object")
  func getEVChargingStationShouldReturnExpectedObjectGivenSaveEVChargingStationIsCalledWithExpectedObject() {
    // Given
    let expectedObject: DomainEVChargingStation = randomDomainEVChargingStation()
    evChargingStationsInMemoryDataSource.saveEVChargingStation(expectedObject)
    
    // When
    let result = evChargingStationsInMemoryDataSource.getEVChargingStation(id: expectedObject.id)
    
    // Then
    #expect(result == expectedObject, "Result does not match expected object")
  }
  
  @Test("getEVChargingStation should return nil given saveEVChargingStation is never called")
  func getEVChargingStationShouldReturnNilGivenSaveEVChargingStationIsNeverCalled() {
    // When
    let result = evChargingStationsInMemoryDataSource.getEVChargingStation(id: "1")
    
    // Then
    #expect(result == nil, "Result does not match nil")
  }
  
  @Test("getEVChargingStation should return nil given deleteEVChargingStation is called with expected id")
  func getEVChargingStationShouldReturnNilGivenDeleteEVChargingStationIsCalledWithExpectedId() {
    // Given
    let expectedObject: DomainEVChargingStation = randomDomainEVChargingStation()
    evChargingStationsInMemoryDataSource.saveEVChargingStation(expectedObject)
    
    // When
    evChargingStationsInMemoryDataSource.deleteEVChargingStation(id: expectedObject.id)
    let result = evChargingStationsInMemoryDataSource.getEVChargingStation(id: expectedObject.id)
    
    // Then
    #expect(result == nil, "Result does not match nil")
  }
}
