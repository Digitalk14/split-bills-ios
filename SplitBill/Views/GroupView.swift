//
//  GroupView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-07.
//

import SwiftUI
import SwiftData

struct GroupView: View {
    
    @State private var  isAddExpenseOpen: Bool = false
    @State private var selectedExpenses = Set<Expense>()
    let group: Group
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text(group.sum, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                    Spacer()
                }
                .padding(.horizontal)
                List(group.expenses,id: \.self, selection: $selectedExpenses){ expense in
                    NavigationLink{
                        EditExpenseView(expense: expense, group: group)
                    }label: {
                        Text(expense.friend.name)
                        Spacer()
                        Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                    }
                    .swipeActions{
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            group.deleteExpense(expense)
                        }
                    }
                }
                Spacer()
                NavigationLink(destination: GroupCalculationsView(group: group)){
                    Text("Check calculations")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue) // Background color for the NavigationLink
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                Spacer()
                
            }
            .navigationTitle(group.name)
            .toolbar{
                Button("Add expense"){
                    isAddExpenseOpen = true
                }
            }
            .sheet(isPresented: $isAddExpenseOpen){
                AddExpenseView(group: group)
            }
        }
    }
}

#Preview {
    GroupView(group: .example)
}
