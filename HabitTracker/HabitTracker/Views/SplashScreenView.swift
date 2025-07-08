//
//  SplashScreenView.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 26/06/25.
//
import SwiftUI

struct SplashScreenView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            
            ContentView(
                viewModel: HabitsViewModel(
                    fetchHabitsUsecase: FetchHabitsUsecase(
                        repository: HabitsRepository(context: viewContext)),
                    addNewHabitUsecase: AddNewHabitUsecase(
                        repository: HabitsRepository(context: viewContext)),
                    deleteHabitUsecase: DeleteHabitUsecase(repository: HabitsRepository(context: viewContext)),
                    updateHabitUsecase: UpdateHabitUsecase(repository: HabitsRepository(context: viewContext))
                )
            )
        } else {
            VStack {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.cyan)
                Text("Habit Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
    }
}
