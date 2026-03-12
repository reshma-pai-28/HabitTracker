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
    let viewModel: HabitsViewModel

    init() {
        let context = persistenceController.container.viewContext
        let repository = HabitsRepository(context: context)
        viewModel = HabitsViewModel(
            fetchHabitsUsecase: FetchHabitsUsecase(repository: repository),
            addNewHabitUsecase: AddNewHabitUsecase(repository: repository),
            deleteHabitUsecase: DeleteHabitUsecase(repository: repository),
            updateHabitUsecase: UpdateHabitUsecase(repository: repository)
        )
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
