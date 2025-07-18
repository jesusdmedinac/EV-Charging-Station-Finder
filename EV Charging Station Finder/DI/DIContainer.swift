//
//  DIContainer.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation
import Swinject

final class DIContainer {
  static let shared = DIContainer()

  private let container: Container
    
  private init() {
    container = Container()
    registerDependencies()
  }
    
  private func registerDependencies() {
    container.register(EVChargingStationsLocalDataSource.self) { _ in
      return EVChargingStationsInMemoryDataSource()
    }.inObjectScope(.container)
    
    container.register(EVChargingStationsRemoteDataSource.self) { _ in
      let session = URLSession.shared
      let decoder = JSONDecoder()
      return EVChargingStationsAPIService(
        session: session,
        decoder: decoder
      )
    }.inObjectScope(.container)
    
    container.register(EVChargingStationMapper.self) { _ in
      return EVChargingStationMapper()
    }
      
    container.register(EVChargingStationsInMemoryDataSource.self) { _ in
      return EVChargingStationsInMemoryDataSource()
    }.inObjectScope(.container)
      
    container.register(EVChargingStationsRepository.self) { resolver in
      let evChargingStationsLocalDataSource = resolver.resolve(EVChargingStationsLocalDataSource.self)!
      let evChargingStationsRemoteDataSource = resolver.resolve(EVChargingStationsRemoteDataSource.self)!
      let evChargingStationMapper = resolver.resolve(EVChargingStationMapper.self)!
          
      return EVChargingStationsRepositoryImpl(
        evChargingStationsLocalDataSource: evChargingStationsLocalDataSource,
        evChargingStationsRemoteDataSource: evChargingStationsRemoteDataSource,
        evChargingStationMapper: evChargingStationMapper
      )
    }.inObjectScope(.container)
  }
    
  func resolve<T>(_ type: T.Type) -> T {
    guard let resolved = container.resolve(type) else {
      fatalError("Failed to resolve \(String(describing: type))")
    }
    return resolved
  }
    
  func resolve<T, Arg1>(_ type: T.Type, argument: Arg1) -> T {
    guard let resolved = container.resolve(type, argument: argument) else {
      fatalError("Failed to resolve \(String(describing: type)) with argument")
      }
      return resolved
    }
}

@propertyWrapper
struct Injected<T> {
  private let type: T.Type
  
  init(_ type: T.Type = T.self) {
    self.type = type
  }
  
  var wrappedValue: T {
    return DIContainer.shared.resolve(type)
  }
}

