//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 19/06/25.
//

import Foundation
import SwiftUI

enum HabitFilter: String, CaseIterable, Identifiable {
    case completed = "Completed"
    case incomplete = "Incomplete"
    case all = "All"
    
    var id: String { self.rawValue }
    
    func getFilterImageName() -> String {
        switch self {
        case .all: ""
        case .completed:  "checkmark.circle"
        case .incomplete:  "circle"
        }
//        Image(systemName: "line.horizontal.3.decrease.circle").tag(HabitFilter.all)
//            Image(systemName: "checkmark.circle").tag(HabitFilter.completed)
//            Image(systemName: "circle").tag(HabitFilter.incomplete)
    }
}

class HabitsViewModel: ObservableObject {
    
    @Published private(set) var habits: [Habit] = []
    @Published var habitName: String = ""
    @Published var isAllHabitsCompleted: Bool = false
    @Published var showIncompleteHabits: Bool = false
    @Published var selectedHabit: Habit?
    @Published var selectedFilter: HabitFilter = .all
    
    
    
    var editingHabitNameBinding: Binding<String> {
        Binding<String>(
            get: {
                self.selectedHabit?.name ?? self.habitName
            },
            set: { newValue in
                if self.selectedHabit != nil {
                    self.selectedHabit?.name = newValue
                } else {
                    self.habitName = newValue
                }
            }
        )
    }
    
    var filteredHabits: [Habit] {
        //showIncompleteHabits ? habits.filter({$0.isCompleted == false}) : habits
        switch selectedFilter {
        case .all: return habits
        case .completed: return habits.filter({$0.isCompleted == true})
        case .incomplete: return habits.filter({$0.isCompleted == false})
        }
    }
    
    private var onSave: (String) -> Void = { _ in }
    
    let fetchHabitsUsecase: FetchHabitsUsecaseProtocol
    let addNewHabitUsecase: AddNewHabitUsecaseProtocol
    let deleteHabitUsecase: DeleteHabitUsecaseProtocol
    let updateHabitUsecase: UpdateHabitUsecaseProtocol
    let habitCompletionUsecase: HabitCompletionUsecaseProtocol
    
    init(fetchHabitsUsecase: FetchHabitsUsecaseProtocol,
         addNewHabitUsecase: AddNewHabitUsecaseProtocol,
         deleteHabitUsecase: DeleteHabitUsecaseProtocol,
         updateHabitUsecase: UpdateHabitUsecaseProtocol,
         habitCompletionUsecase: HabitCompletionUsecaseProtocol) {
        self.fetchHabitsUsecase = fetchHabitsUsecase
        self.addNewHabitUsecase = addNewHabitUsecase
        self.deleteHabitUsecase = deleteHabitUsecase
        self.updateHabitUsecase = updateHabitUsecase
        self.habitCompletionUsecase = habitCompletionUsecase
    }
    
    func fetchHabits() {
        habits = fetchHabitsUsecase.getHabits()
    }
    
    func addNewHabit(name: String) {
        addNewHabitUsecase.addNewHabit(name: name)
        clearTextField()
        fetchHabits()
    }
    
    func deleteHabit(_ habit: Habit) {
        deleteHabitUsecase.deleteHabit(habit)
        fetchHabits()
    }
    
    func clearTextField() {
        habitName = ""
    }
    
    func toggleHabitCompletion(for habit: Habit) {
        updateHabitUsecase.toggleHabitCompletion(habit: habit)
        fetchHabits()
    }
    
    func markAllComplete() {
        updateHabitUsecase.markAllHabitsComplete(isAllHabitsCompleted)
    }
    
    func editHabitName(_ name: String) {
        if let selectedHabit {
            updateHabitUsecase.updateHabit(name: editingHabitNameBinding.wrappedValue, habit: selectedHabit)
            clearTextField()
            fetchHabits()
        }
    }
    
    func isCompletedToday(_ habit: Habit) -> Bool {
        habitCompletionUsecase.isCompletedToday(for: habit)
    }
    
    func getStreakCount(forHabit habit: Habit) -> Int {
        habitCompletionUsecase.getStreakCount(for: habit)
    }

}
