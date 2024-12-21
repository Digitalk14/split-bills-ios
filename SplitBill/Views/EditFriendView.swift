//
//  EditFriendView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-16.
//

import SwiftUI
import SwiftData

struct EditFriendView: View {
    var friend: Friend
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @Query var groups: [Group]
    @State private var showAlert = false
    
    var debtsDebtor: [Debt] {
        groups.flatMap { $0.debts }.filter { $0.debtor == friend && !$0.paid }
    }
    
    var debtsCreditor: [Debt] {
        groups.flatMap { $0.debts }.filter { $0.creditor == friend && !$0.paid }
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Edit"){
                    TextField("Name", text: $name)
                    TextField("E-mail", text: $email)
                }
                if !debtsDebtor.isEmpty{
                    Section("Debts as Debtor"){
                        List(debtsDebtor){ debt in
                            Text("\(friend.name) owes \(formatCurrency(debt.amount)) to \(debt.creditor.name) in \(debt.groupName)")
                                .swipeActions{
                                    Button{
                                        debt.updatePaidStatus()
                                    }label: {
                                        Text("Paid")
                                    }
                                    .tint(.green)
                                }
                        }
                    }
                }
                if !debtsCreditor.isEmpty{
                    Section("Debts as Creditor"){
                        List(debtsCreditor){ debt in
                            Text("\(debt.debtor.name) owes \(formatCurrency(debt.amount)) to \(friend.name) in \(debt.groupName)")
                                .swipeActions{
                                    Button{
                                        debt.updatePaidStatus()
                                    }label: {
                                        Text("Paid")
                                    }
                                    .tint(.green)
                                }
                        }
                    }
                }
                Section{
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Delete Friend")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(debtsDebtor.isEmpty && debtsCreditor.isEmpty ? Color.red.opacity(1.0) :Color.red.opacity(0.5) )
                            .cornerRadius(8)
                    }
                    .disabled(!debtsDebtor.isEmpty || !debtsCreditor.isEmpty)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("This action will permanently delete your friend."),
                            primaryButton: .destructive(Text("Delete")) {
                                print("Friend deleted")
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .listRowInsets(EdgeInsets())
                .background(Color.clear)
                
            }
            .onAppear{
                name = friend.name
                email = friend.emailAddress
            }
            .navigationTitle("Edit friend")
            .toolbar{
                ToolbarItem{
                    Button("Update"){
                        updateFriend()
                        dismiss()
                    }
                    .disabled(name.isEmpty || email.isEmpty)
                }
            }
        }
    }
    func updateFriend(){
        friend.updateFriend(name)
        friend.updateEmail(email)
    }
    
    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "CAD" // Change this to your desired currency code
        formatter.maximumFractionDigits = 2 // Rounds to 2 decimal places
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
}

#Preview {
    EditFriendView(friend: .example)
}
