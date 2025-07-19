//
//  EVChargingStationsInMemoryDataSource.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

class EVChargingStationsInMemoryDataSource : EVChargingStationsLocalDataSource {
  private var evChargingStations: [DomainEVChargingStation] = []
  
  func fetchEVChargingStations() -> [DomainEVChargingStation] {
    return evChargingStations
  }
  
  func saveEVChargingStations(_ items: [DomainEVChargingStation]) {
    evChargingStations = items
  }
  
  func clearEVChargingStations() {
    evChargingStations.removeAll()
  }
  
  func getEVChargingStation(id: String) -> DomainEVChargingStation? {
    return evChargingStations.first(where: { $0.id == id })
  }
  
  func saveEVChargingStation(_ item: DomainEVChargingStation) {
    evChargingStations.append(item)
  }
  
  func deleteEVChargingStation(id: String) {
    evChargingStations = evChargingStations.filter { $0.id != id }
  }
}
