//
//  EVChargingStationsRepositoryImplTests.swift
//  EV Charging Station FinderTests
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Testing
@testable import EV_Charging_Station_Finder
import Foundation

@Suite("EVChargingStationsRepositoryImpl Tests")
struct EVChargingStationsRepositoryImplTests {
  
  private var evChargingStationsRepositoryImpl: EVChargingStationsRepositoryImpl!
  private var mockLocalDataSource: MockEVChargingStationsLocalDataSource!
  private var mockRemoteDataSource: MockEVChargingStationsRemoteDataSource!
  private var mockMapper: MockEVChargingStationMapper!
  
  init() {
    mockLocalDataSource = MockEVChargingStationsLocalDataSource()
    mockRemoteDataSource = MockEVChargingStationsRemoteDataSource()
    mockMapper = MockEVChargingStationMapper()
    
    evChargingStationsRepositoryImpl = EVChargingStationsRepositoryImpl(
      evChargingStationsLocalDataSource: mockLocalDataSource,
      evChargingStationsRemoteDataSource: mockRemoteDataSource,
      evChargingStationMapper: mockMapper
    )
  }

  @Test("fetchStations should return expected stations given fetchEVChargingStations on EVChargingStationsLocalDataSource returns expected stations")
  func fetchStationsShouldReturnExpectedStationsGivenFetchEVChargingStationsOnEVChargingStationsLocalDataSourceReturnsExpectedStations() async {
    // Given
    let expectedStations = [
      DomainEVChargingStation(
        id: Int.random(in: 1...100).description,
      ),
      DomainEVChargingStation(
        id: Int.random(in: 1...100).description,
      )
    ]
    mockLocalDataSource.stubbedFetchEVChargingStationsResult = expectedStations

    // When
    do {
      let result = try await evChargingStationsRepositoryImpl.fetchStations(
        latitude: 0,
        longitude: 0,
        distance: 0
      )
      
      // Then
      #expect(result == expectedStations, "Result does not match expected stations")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("fetchStations should return expected stations given fetchEVChargingStations on EVChargingStationsLocalDataSource returns expected array")
  func fetchStationsShouldReturnExpectedStationsGivenFetchEVChargingStationsOnEVChargingStationsLocalDataSourceReturnsExpectedArray() async {
    // Given
    let expectedStations = [
      DomainEVChargingStation(
        id: Int.random(in: 1...100).description,
      ),
      DomainEVChargingStation(
        id: Int.random(in: 1...100).description,
      )
    ]
    mockLocalDataSource.stubbedFetchEVChargingStationsResult = expectedStations

    // When
    do {
      let result = try await evChargingStationsRepositoryImpl.fetchStations(
        latitude: 0,
        longitude: 0,
        distance: 0
      )
      
      // Then
      #expect(result == expectedStations, "Result does not match expected stations")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("fetchStations should throw data error given fetchEVChargingStations on EVChargingStationsLocalDataSource throws data error")
  func fetchStationsShouldThrowDataErrorGivenFetchEVChargingStationsOnEVChargingStationsLocalDataSourceThrowsDataError() async {
    // Given
    mockLocalDataSource.stubbedFetchEVChargingStationsDataError = .invalidURL

    // When
    do {
      _ = try await evChargingStationsRepositoryImpl.fetchStations(
        latitude: 0,
        longitude: 0,
        distance: 0
      )
      Issue.record("Expected data error not thrown")
    } catch DomainError.data(.invalidURL) {
      // Then expected data error was thrown
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("fetchStations should throw unknown error given fetchEVChargingStations on EVChargingStationsLocalDataSource throws unknown error")
  func fetchStationsShouldThrowUnknownErrorGivenFetchEVChargingStationsOnEVChargingStationsLocalDataSourceThrowsUnknownError() async {
    // Given
    mockLocalDataSource.stubbedFetchEVChargingStationsUnknownError = NSError()

    // When
    do {
      _ = try await evChargingStationsRepositoryImpl.fetchStations(
        latitude: 0,
        longitude: 0,
        distance: 0
      )
      Issue.record("Expected unknown error not thrown")
    } catch DomainError.unknown {
      // Then expected unknown error was thrown
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("removeAllStations should call clearEVChargingStations on EVChargingStationsLocalDataSource")
  func removeAllStationsShouldCallClearEVChargingStationsOnEVChargingStationsLocalDataSource() {
    // Given
    mockLocalDataSource.invokedClearEVChargingStationsCount = 0
    
    // When
    evChargingStationsRepositoryImpl.removeAllStations()
    
    // Then
    #expect(mockLocalDataSource.invokedClearEVChargingStationsCount == 1, "clearEVChargingStations was not called on EVChargingStationsLocalDataSource")
  }
  
  @Test("saveStations should call saveEVChargingStations on EVChargingStationsLocalDataSource") 
  func saveStationsShouldCallSaveEVChargingStationsOnEVChargingStationsLocalDataSource() {
    // Given
    mockLocalDataSource.invokedSaveEVChargingStationsCount = 0
    
    // When
    evChargingStationsRepositoryImpl.saveStations([])
    
    // Then
    #expect(mockLocalDataSource.invokedSaveEVChargingStationsCount == 1, "saveEVChargingStations was not called on EVChargingStationsLocalDataSource")
  }

  @Test("fetchStation should return expected station given getEVChargingStation on EVChargingStationsLocalDataSource returns expected station")
  func fetchStationShouldReturnExpectedStationGivenGetEVChargingStationOnEVChargingStationsLocalDataSourceReturnsExpectedStation() async {
    // Given
    let expectedStation = DomainEVChargingStation(
      id: Int.random(in: 1...100).description,
    )
    mockLocalDataSource.stubbedGetEVChargingStationResult = expectedStation
    
    // When
    do {
      let result = try await evChargingStationsRepositoryImpl.fetchStation(id: expectedStation.id)
      
      // Then
      #expect(result == expectedStation, "Result does not match expected station")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
}

private class MockEVChargingStationsLocalDataSource: EVChargingStationsLocalDataSource {
  var invokedFetchEVChargingStationsCount = 0
  var stubbedFetchEVChargingStationsResult: [DomainEVChargingStation] = []
  var stubbedFetchEVChargingStationsDataError: DataError?
  var stubbedFetchEVChargingStationsUnknownError: Error?
  
  var invokedSaveEVChargingStationsCount = 0
  var invokedSaveEVChargingStationsParameters: (stations: [DomainEVChargingStation], Void)?
  
  var invokedClearEVChargingStationsCount = 0
  
  var invokedGetEVChargingStationCount = 0
  var invokedGetEVChargingStationParameters: (id: String, Void)?
  var stubbedGetEVChargingStationResult: DomainEVChargingStation?
  
  func fetchEVChargingStations() throws -> [DomainEVChargingStation] {
    if let error = stubbedFetchEVChargingStationsDataError {
      throw error
    }
    
    if let error = stubbedFetchEVChargingStationsUnknownError {
      throw error
    }
    
    invokedFetchEVChargingStationsCount += 1
    return stubbedFetchEVChargingStationsResult
  }
  
  func saveEVChargingStations(_ stations: [DomainEVChargingStation]) {
    invokedSaveEVChargingStationsCount += 1
    invokedSaveEVChargingStationsParameters = (stations, ())
  }
  
  func clearEVChargingStations() {
    invokedClearEVChargingStationsCount += 1
  }
  
  func getEVChargingStation(id: String) -> DomainEVChargingStation? {
    invokedGetEVChargingStationCount += 1
    invokedGetEVChargingStationParameters = (id, ())
    return stubbedGetEVChargingStationResult
  }
  
  func saveEVChargingStation(_ station: DomainEVChargingStation) {}
  func deleteEVChargingStation(id: String) {}
}

private class MockEVChargingStationsRemoteDataSource: EVChargingStationsRemoteDataSource {
  var invokedFetchEVChargingStationsCount = 0
  var invokedFetchEVChargingStationsParameters: (latitude: Double, longitude: Double, distance: Double)?
  var stubbedFetchEVChargingStationsResult: [POIResponse] = []
  var stubbedFetchEVChargingStationsError: Error?
  
  func fetchEVChargingStations(latitude: Double, longitude: Double, distance: Double) async throws -> [POIResponse] {
    invokedFetchEVChargingStationsCount += 1
    invokedFetchEVChargingStationsParameters = (latitude, longitude, distance)
    
    if let error = stubbedFetchEVChargingStationsError {
      throw error
    }
    
    return stubbedFetchEVChargingStationsResult
  }
}

private class MockEVChargingStationMapper: EVChargingStationMapper {
  var invokedMapCount = 0
  var stubbedMapResult: [DomainEVChargingStation] = []
  
  override func map(_ responses: [POIResponse]) -> [DomainEVChargingStation] {
    invokedMapCount += 1
    return stubbedMapResult
  }
}
