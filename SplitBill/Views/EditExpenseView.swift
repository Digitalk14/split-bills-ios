//
//  EditExpenseView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-14.
//

import SwiftUI
import SwiftData

struct EditExpenseView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    var expense: Expense
    var group: Group
    @State private var amount: Double = 0
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Enter the amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("\(expense.friend.name)'s expenses")
            .toolbar{
                Button("Update"){
                    updateExpenseAmount()
                    dismiss()
                }
            }
            .onAppear {
                amount = expense.amount
            }
        }
    }
    private func updateExpenseAmount() {
        group.updateExpense(expense, newAmount: amount)
        group.calculateExpenses()
        do {
            try modelContext.save()
        } catch {
            print("Failed to save updated expense: \(error.localizedDescription)")
        }
    }
}

#Preview {
    EditExpenseView(expense: .example, group: .example)
}
