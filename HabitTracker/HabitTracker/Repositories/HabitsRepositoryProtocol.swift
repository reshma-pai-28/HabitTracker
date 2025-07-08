//
//  HabitsRepositoryProtocol.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 23/06/25.
//

import Foundation

protocol HabitsRepositoryProtocol {
    func fetchHabits() -> [Habit]
    func addHabit(_ name: String)
    func deleteHabit(_ habit: Habit)
    func toggleHabitCompletion(_ habit: Habit)
    func markAllHabitsAsCompleted(_ completed: Bool)
    func editHabitName(_ newName: String, _ habit: Habit)
}
