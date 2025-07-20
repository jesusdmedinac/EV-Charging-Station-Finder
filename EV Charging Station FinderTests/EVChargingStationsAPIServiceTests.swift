//
//  EVChargingStationsAPIServiceTests.swift
//  EV Charging Station FinderTests
//
//  Created by Jesus Daniel Medina Cruz on 19/07/25.
//

import Testing
import Foundation
@testable import EV_Charging_Station_Finder

@Suite("EVChargingStationsAPIService Tests")
class EVChargingStationsAPIServiceTests {
  private var evChargingStationsAPIService: EVChargingStationsAPIService
  
  init() {
    evChargingStationsAPIService = EVChargingStationsAPIService()
  }
  
  @Test("fetchEVChargingStations should throw missingAPIKey error given API key is not available")
  func fetchEVChargingStationsShouldThrowMissingAPIKeyErrorGivenAPIKeyIsNotAvailable() async throws {
    // Given
    evChargingStationsAPIService = EVChargingStationsAPIService(
      apiKey: nil,
    )
    
    // When
    do {
      _ = try await evChargingStationsAPIService.fetchEVChargingStations(latitude: 0, longitude: 0, distance: 100)
      Issue.record("Expected missingAPIKey error not thrown")
    } catch DataError.missingAPIKey {
      // Then expected missingAPIKey error was thrown
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
  
  @Test("fetchEVChargingStations should throw invalidURL error given API key is not available")
  func fetchEVChargingStationsShouldThrowInvalidURLErrorGivenAPIKeyIsNotAvailable() async throws {
    // Given
    evChargingStationsAPIService = EVChargingStationsAPIService(
      apiKey: Bundle.main.infoDictionary?["OPEN_CHARGE_MAP_KEY"] as? String ?? "",
      baseUrl: nil
    )
    
    // When
    do {
      _ = try await evChargingStationsAPIService.fetchEVChargingStations(latitude: 0, longitude: 0, distance: 100)
      Issue.record("Expected invalidURL error not thrown")
    } catch DataError.invalidURL {
      // Then expected invalidURL error was thrown
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("fetchEVChargingStations should throw invalidNetworkClient error given network client is nil")
  func fetchEVChargingStationsShouldThrowInvalidNetworkClientErrorGivenInvalidNetworkClient() async throws {
    // Given
    evChargingStationsAPIService = EVChargingStationsAPIService(
      apiKey: "valid_key",
      baseUrl: "https://example.com/",
      networkClient: nil
    )
    
    // When
    do {
      _ = try await evChargingStationsAPIService.fetchEVChargingStations(latitude: 0, longitude: 0, distance: 100)
      Issue.record("Expected invalidNetworkClient error not thrown")
    } catch DataError.invalidNetworkClient {
      // Then expected invalidNetworkClient was thrown
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
  
  @Test("fetchEVChargingStations should throw invalidResponse error given response is not HTTPURLResponse")
  func fetchEVChargingStationsShouldThrowInvalidResponseErrorGivenInvalidResponse() async throws {
    // Given
    let mockNetworkClient = MockNetworkClient(
      data: Data(),
      response: URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    )
    evChargingStationsAPIService = EVChargingStationsAPIService(
      apiKey: "valid_key",
      baseUrl: "https://example.com/",
      networkClient: mockNetworkClient
    )
    
    // When
    do {
      _ = try await evChargingStationsAPIService.fetchEVChargingStations(latitude: 0, longitude: 0, distance: 100)
      Issue.record("Expected invalidResponse error not thrown")
    } catch DataError.invalidResponse {
      // Then expected invalidResponse was thrown
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("fetchEVChargingStations should throw httpError error given statusCode on httpResponse is not in the range 200...299")
  func fetchEVChargingStationsShouldThrowHttpErrorErrorGivenStatusCodeOnHttpResponseIsNotInRange200299() async throws {
    // Given
    let outsideRangeValue: Int = randomIntOutside(range: (200..<300), in: (100..<600)) ?? 0
    let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: outsideRangeValue, httpVersion: nil, headerFields: [:])!
    let mockNetworkClient = MockNetworkClient(
      data: Data(),
      response: response
    )
    evChargingStationsAPIService = EVChargingStationsAPIService(
      apiKey: "valid_key",
      baseUrl: "https://example.com/",
      networkClient: mockNetworkClient
    )
    
    // When
    do {
      _ = try await evChargingStationsAPIService.fetchEVChargingStations(latitude: 0, longitude: 0, distance: 100)
      Issue.record("Expected httpError error not thrown")
    } catch DataError.httpError(let statusCode) {
      // Then expected httpError was thrown
      #expect(statusCode == outsideRangeValue, "Unexpected status code: \(statusCode)")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }

  @Test("fetchEVChargingStations should throw decodingError error given data is not valid JSON")
  func fetchEVChargingStationsShouldThrowDecodingErrorErrorGivenDataIsNotValidJSON() async throws {
    // Given
    let invalidJsonData = Data("invalid json".utf8)
    let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    let mockNetworkClient = MockNetworkClient(
      data: invalidJsonData,
      response: response
    )
    evChargingStationsAPIService = EVChargingStationsAPIService(
      apiKey: "valid_key",
      baseUrl: "https://example.com/",
      networkClient: mockNetworkClient
    )
    
    // When
    do {
      _ = try await evChargingStationsAPIService.fetchEVChargingStations(latitude: 0, longitude: 0, distance: 100)
      Issue.record("Expected decodingError error not thrown")
    } catch DataError.decodingError(let error) {
      // Then expected decodingError was thrown
      #expect(error is DecodingError, "Unexpected error: \(error)")
    } catch {
      Issue.record("Unexpected error: \(error)")
    }
  }
  
  private func randomIntOutside(range: Range<Int>, in fullRange: Range<Int>) -> Int? {
    let lowerRange = fullRange.lowerBound..<range.lowerBound
    let upperRange = range.upperBound..<fullRange.upperBound

    let candidates: [Range<Int>] = [lowerRange, upperRange].filter { !$0.isEmpty }

    guard !candidates.isEmpty else { return nil }

    let selectedRange = candidates.randomElement()!
    return Int.random(in: selectedRange)
  }
}

private class MockNetworkClient : NetworkClient {
  var data: Data
  var response: URLResponse
  
  init(data: Data, response: URLResponse) {
    self.data = data
    self.response = response
  }
  
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    return (data, response)
  }
}
