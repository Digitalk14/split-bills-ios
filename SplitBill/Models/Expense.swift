//
//  Expense.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-07.
//

import Foundation
import SwiftData

@Model
class Expense: Identifiable, Hashable {
    var friend: Friend
    var amount: Double
    
    init(friend: Friend, amount: Double) {
        self.friend = friend
        self.amount = amount
    }
    static let example: Expense = Expense(friend: .example, amount: 100)
}
