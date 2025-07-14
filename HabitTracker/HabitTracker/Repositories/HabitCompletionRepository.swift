//
//  HabitCompletionRepository.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 10/07/25.
//

import Foundation

class HabitCompletionRepository: HabitCompletionRepositoryProtocol {
    
    func isCompletedToday(for habit: Habit) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        guard let completions = habit.completions as? Set<HabitCompletion> else { return false }

        return completions.contains { $0.date != nil && calendar.isDate($0.date!, inSameDayAs: today) }
    }
    
    func getStreakCount(for habit: Habit) -> Int {
        guard let completions = habit.completions as? Set<HabitCompletion> else { return 0 }
        
        let calender = Calendar.current
        let today = calender.startOfDay(for: Date())
        
        let dates = completions.compactMap { $0.date }
            .map { calender.startOfDay(for: $0) }
            .sorted(by: >)
        var streak = 0
        var currentDate = today
        
        for date in dates {
            if calender.isDate(date, inSameDayAs: currentDate) {
                streak += 1
                currentDate = calender.date(byAdding: .day, value: -1, to: currentDate)!
            } else if date < currentDate {
                //Gap found streak broken
                break
            }
        }
        return streak
    }
}
