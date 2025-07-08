//
//  HabitsPresenter.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 24/06/25.
//
import Foundation
import SwiftUI

class HabitsPresenter {
    let habitsUseCase: FetchHabitsUsecase
    let addNewHabitUseCase: AddNewHabitUsecase
    @State private var isPresentingAddHabitView = false
    
    init (habitsUseCase: FetchHabitsUsecase, addNewHabitUseCase: AddNewHabitUsecase) {
        self.habitsUseCase = habitsUseCase
        self.addNewHabitUseCase = addNewHabitUseCase
    }
    
    func showNewAddHabitView() {
        
    }
}
