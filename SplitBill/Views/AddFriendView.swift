//
//  AddFriendView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-06.
//

import SwiftUI
import SwiftData

struct AddFriendView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var emailAddress: String = ""
    var body: some View {
        NavigationStack{
            Form{
                Section(){
                    TextField("Name", text: $name)
                    TextField("E-mail address", text: $emailAddress)
                }
            }.toolbar{
                ToolbarItem{
                    Button("Save"){
                        let newFriend = Friend(name: name, emailAddress: emailAddress)
                        modelContext.insert(newFriend)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel", role: .destructive){
                        name = ""
                        emailAddress = ""
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddFriendView()
}
