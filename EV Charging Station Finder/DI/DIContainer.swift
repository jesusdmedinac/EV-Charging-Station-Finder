//
//  DIContainer.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import Foundation
import Swinject

@MainActor
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
        apiKey: Bundle.main.infoDictionary?["OPEN_CHARGE_MAP_KEY"] as? String ?? "",
        baseUrl: OpenChargeMapAPIConstants.baseURL,
        networkClient: session,
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

    container.register(GetEVChargingStationsUseCase.self) { resolver in
      let repository = resolver.resolve(EVChargingStationsRepository.self)!
      return GetEVChargingStationsUseCaseImpl(repository: repository)
    }.inObjectScope(.container)
    
    container.register(GetEVChargingStationsByIdUseCase.self) { resolver in
      let repository = resolver.resolve(EVChargingStationsRepository.self)!
      return GetEVChargingStationsByIdUseCaseImpl(repository: repository)
    }.inObjectScope(.container)
    
    container.register(UIEVChargingStationMapper.self) { resolver in
      return UIEVChargingStationMapper()
    }.inObjectScope(.container)
    
    container.register(StationsListScreenViewModel.self) { resolver in
      let getEVChargingStationsUseCase = resolver.resolve(GetEVChargingStationsUseCase.self)!
      let uiEVChargingStationMapper = resolver.resolve(UIEVChargingStationMapper.self)!
      return StationsListScreenViewModel(
        getEVChargingStationsUseCase: getEVChargingStationsUseCase,
        uiEVChargingStationMapper: uiEVChargingStationMapper
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
@MainActor
struct Injected<T> {
  private let type: T.Type
  
  init(_ type: T.Type = T.self) {
    self.type = type
  }
  
  var wrappedValue: T {
    return DIContainer.shared.resolve(type)
  }
}

