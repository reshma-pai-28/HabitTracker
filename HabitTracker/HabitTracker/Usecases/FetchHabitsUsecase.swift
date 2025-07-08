//
//  FetchHabitsUsecase.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 23/06/25.
//

struct FetchHabitsUsecase: FetchHabitsUsecaseProtocol {
    
    let repository : HabitsRepositoryProtocol
    
    init(repository: HabitsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getHabits() -> [Habit] {
        repository.fetchHabits()
    }
}
