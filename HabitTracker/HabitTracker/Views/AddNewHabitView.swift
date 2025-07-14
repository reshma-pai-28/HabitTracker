//
//  AddNewHabit.swift
//  HabitTracker
//
//  Created by Punith Shenoy on 19/06/25.
//

import SwiftUI

struct AddNewHabit: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: HabitsViewModel
    @FocusState private var isTextFieldFocussed: Bool
    
    @State var showEmptyHabitAlert: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter habit name", text: viewModel.editingHabitNameBinding)
                    .font(AppFonts.textFieldFont)
                    .foregroundColor(AppColors.titleColor)
                    .focused($isTextFieldFocussed)
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    isTextFieldFocussed = true
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.selectedHabit != nil ? "Edit habit" :"New habit")
                        .font(AppFonts.navigationTitleFont)
                        .foregroundColor(AppColors.appThemeColor)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if viewModel.habitName.isEmpty {
                            showEmptyHabitAlert = true
                        }
                        if !viewModel.habitName.isEmpty && viewModel.selectedHabit == nil{
                            viewModel.addNewHabit(name: viewModel.habitName)
                            dismiss()
                        } else if viewModel.selectedHabit != nil {
                            viewModel.editHabitName(viewModel.habitName)
                            dismiss()
                        }
                        viewModel.selectedHabit = nil
                    }.tint(AppColors.titleColor)
                        .alert("Empty Habit Name", isPresented: $showEmptyHabitAlert) {
                            Button("OK") {
                                showEmptyHabitAlert = false
                            }
                        } message: {
                            Text("Please enter habit name")
                        }

                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.clearTextField()
                        dismiss()
                    }.tint(AppColors.cancelButtonColor)
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let repository = HabitsRepository(context: context)
    let viewModel = HabitsViewModel(
        fetchHabitsUsecase: FetchHabitsUsecase(repository: repository),
        addNewHabitUsecase: AddNewHabitUsecase(repository: repository),
        deleteHabitUsecase: DeleteHabitUsecase(repository: repository),
        updateHabitUsecase: UpdateHabitUsecase(repository: repository), habitCompletionUsecase: HabitCompletionUsecase(repository: HabitCompletionRepository())
    )
    
    AddNewHabit(viewModel: viewModel).environment(\.managedObjectContext, context)
    
}
