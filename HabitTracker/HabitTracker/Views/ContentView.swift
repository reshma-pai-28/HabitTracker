//
//  ContentView.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 18/06/25.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel : HabitsViewModel
    
    @State private var isPresentingAddHabitView = false
    @State private var lastToggledHabit: Habit?
    @State private var showUndoHabitAlert: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(viewModel.filteredHabits) { habit in
                    let isHabitCompleted = viewModel.isCompletedToday(habit)
                    HStack {
                        Button(action: {
                            withAnimation {
                                lastToggledHabit = habit
                                showUndoHabitAlert = true
                                viewModel.toggleHabitCompletion(for: habit)
                            }
                        }) {
                            Image(systemName: isHabitCompleted ? "checkmark.square.fill" : "square")
                                .foregroundColor(isHabitCompleted ? .green : .gray)
                                .imageScale(.large)
                                .transition(.scale.combined(with: .opacity))
                        }.alert("Undo Habit", isPresented: $showUndoHabitAlert) {
                            Button("Undo Habit") {
                                if let habit = lastToggledHabit {
                                    withAnimation {
                                        viewModel.toggleHabitCompletion(for: habit)
                                    }
                                }
                            }
                            Button("Ok") {}
                        } message: {
                            if let lastToggledHabit = lastToggledHabit {
                                if !viewModel.isCompletedToday(lastToggledHabit) {
                                    Text("You are about to mark \(lastToggledHabit.name ?? "") as not completed.")
                                }
//                                else {
//                                    Text("You are about to mark \(lastToggledHabit.name ?? "") as not completed.")
//                                }
                            }
                        }

                        Text(habit.name ?? "" ).strikethrough(isHabitCompleted)
                            .font(AppFonts.titleFont)
                            .foregroundColor(isHabitCompleted ? Color.gray : AppColors.titleColor)
                        Spacer()
                        Text("🔥\(viewModel.getStreakCount(forHabit: habit))")
                        
                    }.swipeActions(edge: .leading) {
                        Button("Edit") {
                            isPresentingAddHabitView = true
                            viewModel.selectedHabit = habit
                        }.tint(AppColors.appThemeColor)
                    }
                }
                .onDelete(perform: deleteItems)
                
            }
            .onAppear {
                viewModel.fetchHabits()
            }
            
            .animation(.easeInOut, value: viewModel.filteredHabits)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(AppColors.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Habits")
                        .font(AppFonts.navigationTitleFont)
                        .foregroundColor(AppColors.appThemeColor)
                }
                
                ToolbarItem {
                    Button(action: {
                        isPresentingAddHabitView = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }.tint(AppColors.titleColor)
                }
                if !viewModel.habits.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .font(AppFonts.navigationTitleFont)
                            .foregroundColor(AppColors.editButtonColor)
                        
                    }
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            viewModel.isAllHabitsCompleted.toggle()
                            viewModel.markAllComplete()
                        } label: {
                            Text("✅ Mark all completed")
                                .font(AppFonts.mediumFont)
                                .foregroundColor(AppColors.appThemeColor)
                        }
                        Spacer()
                        
                        Picker("Filter",
                               selection: $viewModel.selectedFilter) {
                            ForEach(HabitFilter.allCases) { filter in
                                Text(filter.rawValue)
                                    .font(AppFonts.navigationTitleFont)
                                    .foregroundColor(AppColors.appThemeColor)
                                    .tag(filter)
                                
                            }
                        }.padding(8)
                            .tint(AppColors.appThemeColor)
                    }
                }
            }.sheet(isPresented: $isPresentingAddHabitView) {
                AddNewHabit(viewModel: viewModel)
            }
        }.background(AppColors.backgroundColor)
        
        if viewModel.habits.isEmpty {
            Text("Click on "+"+"+" to add your first habit")
                .font(AppFonts.titleFont)
                .foregroundColor(AppColors.appThemeColor)
        }
        
    }

    private func deleteItems(offsets: IndexSet) {
       
        withAnimation {
            offsets.map { viewModel.habits[$0]
            }.forEach { habit in
                viewModel.deleteHabit(habit)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    let context = PersistenceController.preview.container.viewContext
        let repo = HabitsRepository(context: context)
        let vm = HabitsViewModel(
            fetchHabitsUsecase: FetchHabitsUsecase(repository: repo),
            addNewHabitUsecase: AddNewHabitUsecase(repository: repo),
            deleteHabitUsecase: DeleteHabitUsecase(repository: repo),
            updateHabitUsecase: UpdateHabitUsecase(repository: repo), habitCompletionUsecase: HabitCompletionUsecase(repository: HabitCompletionRepository())
        )

    ContentView(viewModel: vm)
}
