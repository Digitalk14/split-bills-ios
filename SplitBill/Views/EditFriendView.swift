//
//  EditFriendView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-16.
//

import SwiftUI

struct EditFriendView: View {
    var friend: Friend
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name", text: $name)
                }
            }
            .onAppear{
                name = friend.name
            }
            .navigationTitle("Edit friend")
            .toolbar{
                Button("Update"){
                    updateFriend()
                    dismiss()
                }
            }
        }
    }
    func updateFriend(){
        friend.updateFriend(name)
    }
}

#Preview {
    EditFriendView(friend: .example)
}
