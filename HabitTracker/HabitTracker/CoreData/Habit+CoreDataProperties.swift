//
//  Habit+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 26/06/25.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var completions: NSSet?

}

extension Habit : Identifiable {

}
