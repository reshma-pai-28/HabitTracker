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
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter habit name", text: $viewModel.draftHabitName)
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
                        let trimmedName = viewModel.draftHabitName.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmedName.isEmpty else {
                            return
                        }

                        viewModel.draftHabitName = trimmedName
                        viewModel.saveHabit()
                        dismiss()
                    }.tint(AppColors.titleColor)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.clearDraft()
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
        updateHabitUsecase: UpdateHabitUsecase(repository: repository)
    )
    
    AddNewHabit(viewModel: viewModel).environment(\.managedObjectContext, context)
    
}
