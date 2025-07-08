//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 18/06/25.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
