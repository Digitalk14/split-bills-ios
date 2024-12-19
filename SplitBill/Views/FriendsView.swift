//
//  FriendsView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-06.
//

import SwiftUI
import SwiftData

struct FriendsView: View {
    @Query var friends: [Friend]
    @State private var isAddFriendVisible: Bool = false
    @State private var searchFriend: String = ""
    
    var filteredFriends: [Friend] {
        if searchFriend.isEmpty {
            return friends
        } else {
            return friends.filter { $0.name.localizedCaseInsensitiveContains(searchFriend) }
        }
    }
    
    var body: some View {
        NavigationStack{
            List(filteredFriends){ friend in
                NavigationLink(friend.name){
                    EditFriendView(friend: friend)
                }
            }
            .navigationTitle("Friends")
            .sheet(isPresented: $isAddFriendVisible){
                AddFriendView()
            }.toolbar{
                ToolbarItem{
                    Button("Add friend", systemImage: "person.badge.plus"){
                        isAddFriendVisible = true
                    }
                }
            }
            
        }
        .searchable(text: $searchFriend)
    }
}

#Preview {
    FriendsView()
}
