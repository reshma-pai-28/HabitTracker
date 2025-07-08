//
//  AddNewHabitUsecase.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 23/06/25.
//

struct AddNewHabitUsecase: AddNewHabitUsecaseProtocol {
    let repository: HabitsRepository
    
    init(repository: HabitsRepository) {
        self.repository = repository
    }
    
    func addNewHabit(name: String) {
        repository.addHabit(name)
    }
}
