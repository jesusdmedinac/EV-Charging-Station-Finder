//
//  EVChargingStationsInMemoryDataSource.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

class EVChargingStationsInMemoryDataSource : EVChargingStationsLocalDataSource {
  private var evChargingStations: [EVChargingStation] = []
  
  func fetchEVChargingStations() -> [EVChargingStation] {
    return evChargingStations
  }
  
  func saveEVChargingStations(_ items: [EVChargingStation]) {
    evChargingStations = items
  }
  
  func clearEVChargingStations() {
    evChargingStations.removeAll()
  }
  
  func getEVChargingStation(id: String) -> EVChargingStation? {
    return evChargingStations.first(where: { $0.id == id })
  }
  
  func saveEVChargingStation(_ item: EVChargingStation) {
    evChargingStations.append(item)
  }
  
  func deleteEVChargingStation(id: String) {
    evChargingStations = evChargingStations.filter { $0.id != id }
  }
}
