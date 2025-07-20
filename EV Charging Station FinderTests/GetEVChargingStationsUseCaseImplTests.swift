//
//  GetEVChargingStationsUseCaseImplTests.swift
//  EV Charging Station FinderTests
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Testing
@testable import EV_Charging_Station_Finder

@Suite("GetEVChargingStationsUseCaseImpl Tests")
struct GetEVChargingStationsUseCaseImplTests {
  
  private var getEVChargingStationsUseCase: GetEVChargingStationsUseCaseImpl!
  private var mockRepository: MockEVChargingStationsRepository!
  
  init() {
    mockRepository = MockEVChargingStationsRepository()
    getEVChargingStationsUseCase = GetEVChargingStationsUseCaseImpl(repository: mockRepository)
  }
  
  @Test("execute should return expected stations given repository returns expected stations")
  func executeShouldReturnExpectedStationsGivenRepositoryReturnsExpectedStations() async {
    // Given
    let expectedStations = [
      DomainEVChargingStation(),
      DomainEVChargingStation()
    ]
    mockRepository.stubbedFetchStationsResult = expectedStations
    
    // When
    do {
      let result = try await getEVChargingStationsUseCase.execute(
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
  
  @Test("execute should call repository with correct parameters")
  func executeShouldCallRepositoryWithCorrectParameters() async {
    // Given
    let expectedLatitude = 40.7128
    let expectedLongitude = -74.0060
    let expectedDistance = 100.0
    
    // When
    do {
      _ = try await getEVChargingStationsUseCase.execute(
        latitude: expectedLatitude,
        longitude: expectedLongitude,
        distance: expectedDistance
      )
      
      // Then
      #expect(mockRepository.invokedFetchStationsCount == 1, "fetchStations should be called once")
      #expect(mockRepository.invokedFetchStationsParameters?.latitude == expectedLatitude, "Latitude does not match")
      #expect(mockRepository.invokedFetchStationsParameters?.longitude == expectedLongitude, "Longitude does not match")
      #expect(mockRepository.invokedFetchStationsParameters?.distance == expectedDistance, "Distance does not match")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
  
  @Test("execute should throw error given repository throws error")
  func executeShouldThrowErrorGivenRepositoryThrowsError() async {
    // Given
    mockRepository.stubbedFetchStationsError = DataError.invalidURL
    
    // When
    do {
      _ = try await getEVChargingStationsUseCase.execute(
        latitude: 0,
        longitude: 0,
        distance: 0
      )
      Issue.record("Expected error not thrown")
    } catch {
      // Then expected error was thrown
      #expect(error is DataError, "Error type does not match")
    }
  }
}
