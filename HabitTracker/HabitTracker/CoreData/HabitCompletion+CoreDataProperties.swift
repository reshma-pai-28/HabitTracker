//
//  HabitCompletion+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 08/07/25.
//
//

import Foundation
import CoreData


extension HabitCompletion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitCompletion> {
        return NSFetchRequest<HabitCompletion>(entityName: "HabitCompletion")
    }

    @NSManaged public var date: Date?
    @NSManaged public var habit: Habit?

}

extension HabitCompletion : Identifiable {

}
