//
//  UpdateHabitUsecaseProtocol.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 27/06/25.
//

protocol UpdateHabitUsecaseProtocol {
    func toggleHabitCompletion(habit: Habit)
    func markAllHabitsComplete(_  isComplete: Bool)
    func updateHabit(name: String, habit: Habit)
}
