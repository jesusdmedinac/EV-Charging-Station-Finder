//
//  NetworkClient.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 19/07/25.
//

import Foundation

protocol NetworkClient {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
