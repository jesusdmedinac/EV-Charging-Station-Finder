//
//  EVChargingStationsAPIService.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation

extension URLSession: NetworkClient {}

class EVChargingStationsAPIService : EVChargingStationsRemoteDataSource {
  private let apiKey: String?
  private let baseUrl: String?
  private let networkClient: NetworkClient?
  private let decoder: JSONDecoder
  
  init(apiKey: String? = nil, baseUrl: String? = nil, networkClient: NetworkClient? = nil, decoder: JSONDecoder = JSONDecoder()) {
    self.apiKey = apiKey
    self.baseUrl = baseUrl
    self.networkClient = networkClient
    self.decoder = decoder
  }

  func fetchEVChargingStations(latitude: Double, longitude: Double, distance: Double) async throws -> [POIResponse] {
    guard let openChargeMapKey: String = apiKey else {
      throw EVChargingAPIError.missingAPIKey
    }
    
    guard let baseUrl: String = baseUrl else {
      throw EVChargingAPIError.invalidURL
    }
      
    let stringUrl = "\(baseUrl)poi?output=json&lat=\(latitude)&lon=\(longitude)&distance=\(distance)&maxresults=10&key=\(openChargeMapKey)"
    
    guard let url = URL(string: stringUrl) else {
      throw EVChargingAPIError.invalidURL
    }
    
    let request = URLRequest(url: url)
    
    do {
      guard let networkClient: NetworkClient = networkClient else {
        throw EVChargingAPIError.invalidNetworkClient
      }
      
      let (data, response) = try await networkClient.data(for: request)
        
      guard let httpResponse = response as? HTTPURLResponse else {
        throw EVChargingAPIError.invalidResponse
      }
        
      guard (200...299).contains(httpResponse.statusCode) else {
        throw EVChargingAPIError.httpError(httpResponse.statusCode)
      }
        
      do {
        if let jsonString = String(data: data, encoding: .utf8) {
          print("🔵 JSON received (first 500 characters):")
          print(jsonString.prefix(500))
        }
        
        do {
          let poiResponse = try decoder.decode([POIResponse].self, from: data)
          print("✅ Decoding successful")
          return poiResponse
        } catch let decodingError as DecodingError {
          print("❌ Decoding error:")
          switch decodingError {
          case .dataCorrupted(let context):
            print("Data corrupted: \(context.debugDescription)")
            print("Coding Path: \(context.codingPath)")
          case .keyNotFound(let key, let context):
            print("Key not found: \(key.stringValue)")
            print("Coding Path: \(context.codingPath)")
          case .typeMismatch(_, let context):
            print("Type mismatch: \(context.debugDescription)")
            print("Coding Path: \(context.codingPath)")
          case .valueNotFound(_, let context):
            print("Value not found: \(context.debugDescription)")
            print("Coding Path: \(context.codingPath)")
          @unknown default:
            print("Unknown decoding error")
          }
          
          do {
            let singlePOI = try decoder.decode(POIResponse.self, from: data)
            print("⚠️ Decoded as a single object instead of an array")
            return [singlePOI]
          } catch  {
            throw EVChargingAPIError.decodingError(decodingError)
          }
        }
      }
    } catch let error as EVChargingAPIError {
      throw error
    } catch {
      throw EVChargingAPIError.networkError(error)
    }
  }
}

