//
//  HabitCompletionUsecaseProtocol.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 10/07/25.
//

protocol HabitCompletionUsecaseProtocol {
    func isCompletedToday(for habit: Habit) -> Bool
    func getStreakCount(for habit: Habit) -> Int
}
