//
//  ServiceOnBookingApp.swift
//  ServiceOnBooking
//
//  Created by Максим Чесников on 19.12.2021.
//

import SwiftUI

@main
struct ServiceOnBookingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
