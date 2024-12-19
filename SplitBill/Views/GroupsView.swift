//
//  GroupsView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-06.
//

import SwiftUI
import SwiftData

struct GroupsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var groups: [Group]
    @State private var isAddGroupShown = false
    @State private var searchGroup: String = ""
    
    var filteredGroups: [Group] {
        if searchGroup.isEmpty {
            return groups
        } else {
            return groups.filter { $0.name.localizedCaseInsensitiveContains(searchGroup) }
        }
    }
    
    var body: some View {
        NavigationStack{
            List(filteredGroups){group in
                NavigationLink(group.name){
                    GroupView(group: group)
                }
                .swipeActions{
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        deleteGroup(group)
                    }
                }
            }
            .navigationTitle("Groups")
            .sheet(isPresented: $isAddGroupShown){
                AddGroupView()
            }
            .toolbar{
                ToolbarItem{
                    Button("Add friend", systemImage: "plus.circle"){
                        isAddGroupShown = true
                    }
                }
            }
        }
        .searchable(text: $searchGroup)
    }
    private func deleteGroup(_ group: Group) {
        modelContext.delete(group)
        do {
            try modelContext.save() // Save the context to persist changes
        } catch {
            // Handle any errors that occur during saving
            print("Failed to save context after deleting expense: \(error)")
        }
    }
}

#Preview {
    //    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    //    let container = try! ModelContainer(for: Group.self, configurations: config)
    //
    //    let group = Group.example
    //    container.mainContext.insert(group)
    
    GroupsView()
}
