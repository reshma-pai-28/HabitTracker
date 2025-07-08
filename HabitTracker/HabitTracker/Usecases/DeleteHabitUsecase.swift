//
//  DeleteHabitUsecase.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 26/06/25.
//

class DeleteHabitUsecase: DeleteHabitUsecaseProtocol {
    
    let repository: HabitsRepositoryProtocol
    
    init(repository: HabitsRepositoryProtocol) {
        self.repository = repository
    }
    
    func deleteHabit(_ habit: Habit) {
        repository.deleteHabit(habit)
    }
}
