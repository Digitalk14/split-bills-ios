//
//  AddGroupView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-06.
//

import SwiftUI
import SwiftData

struct AddGroupView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Group Name", text: $name)
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add"){
                        let newGroup = Group(name: name, expenses: [])
                        modelContext.insert(newGroup)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        name = ""
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddGroupView()
}
