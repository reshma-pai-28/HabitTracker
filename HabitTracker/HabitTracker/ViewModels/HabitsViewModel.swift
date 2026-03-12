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
    @Published var isAllHabitsCompleted: Bool = false
    @Published var selectedHabit: Habit?
    @Published var draftHabitName: String = ""
    @Published var selectedFilter: HabitFilter = .all
    
    var filteredHabits: [Habit] {
        switch selectedFilter {
        case .all: return habits
        case .completed: return habits.filter({$0.isCompleted == true})
        case .incomplete: return habits.filter({$0.isCompleted == false})
        }
    }
    
    let fetchHabitsUsecase: FetchHabitsUsecaseProtocol
    let addNewHabitUsecase: AddNewHabitUsecaseProtocol
    let deleteHabitUsecase: DeleteHabitUsecaseProtocol
    let updateHabitUsecase: UpdateHabitUsecaseProtocol
    
    init(fetchHabitsUsecase: FetchHabitsUsecaseProtocol,
         addNewHabitUsecase: AddNewHabitUsecaseProtocol,
         deleteHabitUsecase: DeleteHabitUsecaseProtocol,
         updateHabitUsecase: UpdateHabitUsecaseProtocol) {
        self.fetchHabitsUsecase = fetchHabitsUsecase
        self.addNewHabitUsecase = addNewHabitUsecase
        self.deleteHabitUsecase = deleteHabitUsecase
        self.updateHabitUsecase = updateHabitUsecase
    }
    
    func fetchHabits() {
        habits = fetchHabitsUsecase.getHabits()
    }
    
    func addNewHabit(name: String) {
        addNewHabitUsecase.addNewHabit(name: name)
        clearDraft()
        fetchHabits()
    }
    
    func deleteHabit(_ habit: Habit) {
        deleteHabitUsecase.deleteHabit(habit)
        fetchHabits()
    }
    
    func clearDraft() {
        draftHabitName = ""
        selectedHabit = nil
    }
    
    func toggleHabitCompletion(for habit: Habit) {
        updateHabitUsecase.toggleHabitCompletion(habit: habit)
        fetchHabits()
    }
    
    func markAllComplete() {
        updateHabitUsecase.markAllHabitsComplete(isAllHabitsCompleted)
        fetchHabits()
    }
    
    func startAddingHabit() {
        selectedHabit = nil
        draftHabitName = ""
    }
    
    func startEditing(_ habit: Habit) {
        selectedHabit = habit
        draftHabitName = habit.name ?? ""
    }
    
    func saveHabit() {
        if let selectedHabit {
            updateHabitUsecase.updateHabit(name: draftHabitName, habit: selectedHabit)
            fetchHabits()
        } else {
            addNewHabitUsecase.addNewHabit(name: draftHabitName)
            fetchHabits()
        }
        clearDraft()
    }
}
