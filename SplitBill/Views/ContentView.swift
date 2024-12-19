//
//  ContentView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-08-16.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            FriendsView()
                .tabItem {
                    Label("Friends", systemImage: "heart.circle")
                }
            GroupsView()
                .tabItem {
                    Label("Groups", systemImage: "person.2")
                }
            CalculationsView()
                .tabItem {
                    Label("Calculations", systemImage: "plus.slash.minus")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
