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
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(viewModel.filteredHabits) { habit in
                    HStack {
                        Button(action: {
                            viewModel.toggleHabitCompletion(for: habit)
                        }) {
                            Image(systemName: habit.isCompleted ? "checkmark.square.fill" : "square")
                                .foregroundColor(habit.isCompleted ? .green : .gray)
                                .imageScale(.large)
                        }
                        Text(habit.name ?? "" ).strikethrough(habit.isCompleted)
                            .font(AppFonts.titleFont)
                            .foregroundColor(habit.isCompleted ? Color.gray : AppColors.titleColor)
                        
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
                                .font(AppFonts.descriptionFont)
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
            updateHabitUsecase: UpdateHabitUsecase(repository: repo)
        )

    ContentView(viewModel: vm)
}
