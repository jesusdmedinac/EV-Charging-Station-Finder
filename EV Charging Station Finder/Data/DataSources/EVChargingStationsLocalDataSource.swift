//
//  EVChargingStationsLocalDataSource.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

protocol EVChargingStationsLocalDataSource {
  // Fetches all EV charging stations
  // - Returns: Array of EVChargingStation objects
  func fetchEVChargingStations() -> [EVChargingStation]
  
  // Saves an array of EV charging stations
  // - Parameter items: Array of EVChargingStation objects to save
  func saveEVChargingStations(_ items: [EVChargingStation])
  
  // Clears all EV charging stations
  // - Returns: Void
  func clearEVChargingStations()
  
  // Fetches a single EV charging station by ID
  // - Parameter id: The ID of the EV charging station to fetch
  // - Returns: The EVChargingStation object if found, nil otherwise
  func getEVChargingStation(id: String) -> EVChargingStation?
  
  // Saves a single EV charging station
  // - Parameter item: The EVChargingStation object to save
  func saveEVChargingStation(_ item: EVChargingStation)
  
  // Deletes a single EV charging station by ID
  // - Parameter id: The ID of the EV charging station to delete
  func deleteEVChargingStation(id: String)
}
