//
//  HabitsRepository.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 23/06/25.
//

import CoreData
import SwiftUICore
import SwiftUI

struct HabitsRepository: HabitsRepositoryProtocol {
    
    private let viewContext: NSManagedObjectContext

        init(context: NSManagedObjectContext) {
            self.viewContext = context
        }
    
    func fetchHabits() -> [Habit] {
        
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Habit.name, ascending: true)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    
    func addHabit(_ name: String) {
//        let backgroundContext = PersistenceController.shared.container.newBackgroundContext()
//        backgroundContext.perform {
        let newItem = Habit(context: viewContext)
            newItem.name = name
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        //}
        
    }
    
    func deleteHabit(_ habit: Habit) {
        do {
            viewContext.delete(habit)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func toggleHabitCompletion(_ habit: Habit) {
        habit.isCompleted.toggle()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func markAllHabitsAsCompleted(_ completed: Bool) {
        let allHabits = fetchHabits()
        allHabits.forEach { $0.isCompleted = completed }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func editHabitName(_ newName: String, _ habit: Habit) {
        habit.name = newName
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
