//
//  EV_Charging_Station_FinderApp.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 17/07/25.
//

import SwiftUI
import SwiftData

@main
struct EV_Charging_Station_FinderApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
