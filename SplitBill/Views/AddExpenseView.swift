//
//  AddExpenseView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-08.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    let group: Group
    
    @Environment(\.dismiss) var dismiss
    @Query(sort: [SortDescriptor(\Friend.name)]) var allFriends: [Friend]
    
    var filteredFriends: [Friend] {
        allFriends.filter { friend in
            !group.expenses.contains(where: { $0.friend == friend })
        }
    }
    
    @State private var selectedFriend: Friend?
    @State private var amount: Double = 0
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Choose friend",selection: $selectedFriend){
                        ForEach(filteredFriends){ friend in
                            Text(friend.name).tag(friend as Friend?)
                        }
                    }
                    TextField("Enter the amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                    
                }
                
            }.navigationTitle("New expense")
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel"){
                            dismiss()
                        }
                    }
                    ToolbarItem{
                        Button("Add"){
                            guard let selectedFriend = selectedFriend else { return }
                            let newExpense = Expense(friend: selectedFriend , amount: amount)
                            group.addExpense(newExpense)
                            group.calculateExpenses()
                            dismiss()
                        }
                        .disabled(selectedFriend == nil)
                    }
                }
        }
    }
}

#Preview {
    AddExpenseView(group: .example)
}
