//
//  SplashScreenView.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 26/06/25.
//
import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var viewModel: HabitsViewModel
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            ContentView(viewModel: viewModel)
        } else {
            VStack {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.cyan)
                Text("Habit Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
    }
}
