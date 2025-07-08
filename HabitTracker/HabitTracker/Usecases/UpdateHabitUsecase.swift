//
//  UpdateHabitUsecase.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 27/06/25.
//

class UpdateHabitUsecase: UpdateHabitUsecaseProtocol {
    
    let repository: HabitsRepositoryProtocol
    
    init(repository: HabitsRepositoryProtocol) {
        self.repository = repository
    }
    
    func toggleHabitCompletion(habit: Habit) {
        repository.toggleHabitCompletion(habit)
    }
    
    func markAllHabitsComplete(_ isComplete: Bool) {
        repository.markAllHabitsAsCompleted(isComplete)
    }
    
    func updateHabit(name: String, habit: Habit) {
        repository.editHabitName(name, habit)
    }
}
