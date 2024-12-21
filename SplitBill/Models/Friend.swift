//
//  File.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-06.
//

import SwiftData
import Foundation

@Model
class Friend: Hashable, Equatable {
    var name: String
    var emailAddress: String
    
    init(name: String, emailAddress: String) {
        self.name = name
        self.emailAddress = emailAddress
    }
    
    static let empty = Friend(name: "", emailAddress: "")
    static let example = Friend(name: "Dmitrii", emailAddress: "dmitrii@vasilev.dev")
    
    func updateFriend (_ newName: String) {
        name = newName
    }
    
    func updateEmail (_ newEmail: String) {
        emailAddress = newEmail
    }
    
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.name == rhs.name
    }
}
