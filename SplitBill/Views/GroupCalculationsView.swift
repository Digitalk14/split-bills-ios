//
//  GroupCalculationsView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-10.
//

import SwiftUI

struct GroupCalculationsView: View {
    var group: Group
    @State private var groupCalculations: [String] = []
    var body: some View {
        NavigationStack{
            List(group.debts){ debt in
                HStack{
                    Text("\(debt.debtor.name) owes \(group.formatCurrency(debt.amount)) to \(debt.creditor.name)")
                    Spacer()
                    if debt.paid {
                        Image(systemName: "checkmark.circle")
                    }
                    
                }
                .navigationTitle("\(group.name) calcs")
                .swipeActions{
                    Button{
                        debt.updatePaidStatus()
                    }label: {
                        if debt.paid {
                            Text("Unpaid")

                        }else{
                            Text("Paid")
                        }
                                            }
                    .tint(debt.paid ? .yellow :.green)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if !groupCalculations.isEmpty {
                        ShareLink(item: generateShareText(), subject: Text("\(group.name) Expenses"), message: Text("Here's the calculated expenses for \(group.name)."))
                    }
                }
            }
        }
    }
    private func generateShareText() -> String {
        groupCalculations.joined(separator: "\n")
    }
}

#Preview {
    GroupCalculationsView(group: .example)
}
