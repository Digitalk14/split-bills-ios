//
//  Group.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-06.
//

import SwiftData
import SwiftUI
import Foundation

@Model
class Debt {
    
    var debtor: Friend
    var creditor: Friend
    var amount: Double
    var paid: Bool
    var groupName: String
    init(debtor: Friend, creditor: Friend, amount: Double, paid: Bool = false, groupName: String) {
        self.debtor = debtor
        self.creditor = creditor
        self.amount = amount
        self.paid = paid
        self.groupName = groupName
    }
    
    func updatePaidStatus() {
        paid.toggle()
    }
}

@Model
class Group {
    var name: String
    var sum: Double = 0
    var expenses = [Expense]()
    var debts = [Debt]()
    
    init(name: String, expenses: [Expense]) {
        self.name = name
        self.expenses = expenses
    }
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        sum += expense.amount
    }
    func deleteExpense(_ expense: Expense) {
        expenses.removeAll(where: { $0 == expense })
        sum -= expense.amount
    }
    
    func updateExpense(_ expense: Expense, newAmount: Double) {
        guard let index = expenses.firstIndex(where: { $0 == expense }) else {
            print("Expense not found in the group.")
            return
        }
        let oldAmount = expenses[index].amount
        expenses[index].amount = newAmount
        sum += (newAmount - oldAmount) // Adjust the sum
    }
    
    func calculateExpenses() {
        // Dictionary to track each friend's net balance
        var balances: [Friend: Double] = [:]
        
        // Initialize balances for each friend
        for expense in expenses {
            balances[expense.friend, default: 0] += expense.amount
        }
        
        // Calculate the total amount spent and the fair share per friend
        let totalAmount = balances.values.reduce(0, +)
        let friendsCount = balances.keys.count
        let fairShare = totalAmount / Double(friendsCount)
        
        // Adjust balances to reflect how much each friend owes or is owed
        for (friend, amount) in balances {
            balances[friend] = amount - fairShare
        }
        
        // Sort friends into those who owe money and those who are owed money
        var owesMoney = balances.filter { $0.value < 0 } // Negative balances
        var isOwedMoney = balances.filter { $0.value > 0 } // Positive balances
        
        var transactions: [String] = []
        debts.removeAll()
        // Match those who owe money with those who are owed money
        while let (debtor, debtAmount) = owesMoney.first, let (creditor, creditAmount) = isOwedMoney.first {
            let settlementAmount: Double = min(-debtAmount, creditAmount)
            
            // Record the transaction
            transactions.append("\(debtor.name) owes \(formatCurrency(settlementAmount)) to \(creditor.name)")
            
            let newDebt = Debt(debtor: debtor, creditor: creditor, amount: settlementAmount, groupName: name)
            debts.append(newDebt)
            
            // Update balances
            owesMoney[debtor] = debtAmount + settlementAmount
            isOwedMoney[creditor] = creditAmount - settlementAmount
            
            // Remove settled entries
            if owesMoney[debtor] == 0 {
                owesMoney.removeValue(forKey: debtor)
            }
            if isOwedMoney[creditor] == 0 {
                isOwedMoney.removeValue(forKey: creditor)
            }
        }
        
    }
    
    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "CAD" // Change this to your desired currency code
        formatter.maximumFractionDigits = 2 // Rounds to 2 decimal places
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
    
    static let example = Group(name: "Camping", expenses: [])
}
