//
//  AppFonts.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 27/06/25.
//

import SwiftUI

struct AppFonts {
    var font: Font
    
    init(_ font: Font = .system(size: 17)) {
        self.font = font
    }
    
    static let titleFont = Font.system(size: 18).weight(.heavy)
    static let splashScreenTitleFont = Font.largeTitle.weight(.bold)
    static let navigationTitleFont = Font.system(size: 20, weight: .bold)
    static let descriptionFont = Font.system(size: 14).weight(.medium)
    static let textFieldFont = Font.system(size: 17).weight(.semibold)

}
