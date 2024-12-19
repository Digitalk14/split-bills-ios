//
//  SplitBillApp.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-08-16.
//

import SwiftUI
import SwiftData

@main
struct SplitBillApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Friend.self, Group.self])
    }
}
