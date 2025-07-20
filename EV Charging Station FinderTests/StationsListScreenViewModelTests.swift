//
//  StationsListScreenViewModelTests.swift
//  EV Charging Station FinderTests
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Testing
@testable import EV_Charging_Station_Finder

@MainActor
@Suite("StationsListScreenViewModel Tests")
struct StationsListScreenViewModelTests {
  
  private var stationsListScreenViewModel: StationsListScreenViewModel!
  private var mockGetEVChargingStationsUseCase: MockGetEVChargingStationsUseCase!
  private var mockUIEVChargingStationMapper: MockUIEVChargingStationMapper!
  
  init() {
    mockGetEVChargingStationsUseCase = MockGetEVChargingStationsUseCase()
    mockUIEVChargingStationMapper = MockUIEVChargingStationMapper()
    
    stationsListScreenViewModel = StationsListScreenViewModel(
      getEVChargingStationsUseCase: mockGetEVChargingStationsUseCase,
      uiEVChargingStationMapper: mockUIEVChargingStationMapper
    )
  }

  @Test("stations should be updated with expected stations given execute on GetEVChargingStationsUseCase returns expected stations")
  func stationsShouldBeUpdatedWithExpectedStationsGivenExecuteOnGetEVChargingStationsUseCaseReturnsExpectedStations() async {
    // Given
    mockGetEVChargingStationsUseCase.stubbedExecuteResult = [
      DomainEVChargingStation(),
      DomainEVChargingStation()
    ]
    mockUIEVChargingStationMapper.stubbedMapResult = UIEVChargingStation()
    
    // When
    do {
      _ = try await stationsListScreenViewModel.fetchStations()
      let stations = stationsListScreenViewModel.stations
      
      // Then
      #expect(stations == [UIEVChargingStation(), UIEVChargingStation()], "Stations do not match expected stations")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("isLoading should be set to false after fetchStations is called")
  func isLoadingShouldBeSetToFalseAfterFetchStationsIsCalled() async {
    // Given
    
    // When
    do {
      _ = try await stationsListScreenViewModel.fetchStations()
      let isLoading = stationsListScreenViewModel.isLoading
      
      // Then
      #expect(isLoading == false, "isLoading should be set to false after fetchStations is called")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
}

private class MockGetEVChargingStationsUseCase: GetEVChargingStationsUseCase {
  var invokedExecuteCount = 0
  var invokedExecuteParameters: (latitude: Double, longitude: Double, distance: Double)?
  var stubbedExecuteResult: [DomainEVChargingStation] = []
  var stubbedExecuteError: Error?
  
  func execute(latitude: Double, longitude: Double, distance: Double) async throws -> [DomainEVChargingStation] {
    invokedExecuteCount += 1
    invokedExecuteParameters = (latitude, longitude, distance)
    
    if let error = stubbedExecuteError {
      throw error
    }
    
    return stubbedExecuteResult
  }
}

private class MockUIEVChargingStationMapper: UIEVChargingStationMapper {
  var invokedMapCount = 0
  var stubbedMapResult: UIEVChargingStation?
  
  override func map(_ domain: DomainEVChargingStation) -> UIEVChargingStation? {
    invokedMapCount += 1
    return stubbedMapResult ?? UIEVChargingStation()
  }
}

