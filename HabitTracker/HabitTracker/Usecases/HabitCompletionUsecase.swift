//
//  HabitCompletionUsecase.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 10/07/25.
//

class HabitCompletionUsecase : HabitCompletionUsecaseProtocol {
    
    let repository: HabitCompletionRepositoryProtocol
    
    init(repository: HabitCompletionRepositoryProtocol) {
        self.repository = repository
    }
    
    func isCompletedToday(for habit: Habit) -> Bool {
        repository.isCompletedToday(for: habit)
    }
    
    func getStreakCount(for habit: Habit) -> Int {
        repository.getStreakCount(for: habit)
    }
}
