//
//  GetEVChargingStationsByIdUseCaseImplTests.swift
//  EV Charging Station FinderTests
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import Testing
@testable import EV_Charging_Station_Finder

@Suite("GetEVChargingStationsByIdUseCaseImpl Tests")
struct GetEVChargingStationsByIdUseCaseImplTests {
  
  private var getEVChargingStationsByIdUseCase: GetEVChargingStationsByIdUseCaseImpl!
  private var mockRepository: MockEVChargingStationsRepository!
  
  init() {
    mockRepository = MockEVChargingStationsRepository()
    getEVChargingStationsByIdUseCase = GetEVChargingStationsByIdUseCaseImpl(repository: mockRepository)
  }
  
  @Test("execute should return expected station given repository returns expected station")
  func executeShouldReturnExpectedStationGivenRepositoryReturnsStation() async {
    // Given
    let expectedStation = DomainEVChargingStation()
    mockRepository.stubbedFetchStationResult = expectedStation
    
    // When
    do {
      let result = try await getEVChargingStationsByIdUseCase.execute(id: expectedStation.id)
      
      // Then
      #expect(result == expectedStation, "Result does not match expected station")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
  
  @Test("execute should call repository with correct id")
  func executeShouldCallRepositoryWithCorrectId() async {
    // Given
    let expectedId = "test-id-123"
    
    // When
    do {
      _ = try? await getEVChargingStationsByIdUseCase.execute(id: expectedId)
      
      // Then
      #expect(mockRepository.invokedFetchStationParameters?.id == expectedId, "ID does not match")
    }
  }
  
  @Test("execute should throw notFound error given repository returns nil")
  func executeShouldThrowNotFoundErrorGivenRepositoryReturnsNil() async {
    // Given
    mockRepository.stubbedFetchStationResult = nil
    
    // When
    do {
      _ = try await getEVChargingStationsByIdUseCase.execute(id: "non-existent-id")
      Issue.record("Expected notFound error not thrown")
    } catch DomainError.notFound {
      // Then expected error was thrown
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
  
  @Test("execute should throw error given repository throws error")
  func executeShouldThrowErrorGivenRepositoryThrowsError() async {
    // Given
    mockRepository.stubbedFetchStationError = DataError.invalidURL
    
    // When
    do {
      _ = try await getEVChargingStationsByIdUseCase.execute(id: "test-id")
      Issue.record("Expected error not thrown")
    } catch {
      // Then expected error was thrown
      #expect(error is DataError, "Error type does not match")
    }
  }
}
