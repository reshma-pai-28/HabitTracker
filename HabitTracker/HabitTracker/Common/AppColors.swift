//
//  AppColors.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 27/06/25.
//

import SwiftUI

import SwiftUI

struct AppColors {
    
    static var titleColor: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? .white : .black
        }).opacity(0.75)
    }

    static var backgroundColor: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.systemGray6 : UIColor.gray.withAlphaComponent(0.2)
        })
    }

    static var appThemeColor: Color {
        Color(UIColor { trait in
            (trait.userInterfaceStyle == .dark ? UIColor.systemTeal : .appCyan)
        })
    }

    static var editButtonColor: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.lightGray : UIColor.black.withAlphaComponent(0.5)
        })
    }

    static var cancelButtonColor: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.systemRed : UIColor.red
        })
    }

    static var markAllAsDoneButtonColor: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.green.withAlphaComponent(0.5) : UIColor.green.withAlphaComponent(0.7)
        })
    }
}

