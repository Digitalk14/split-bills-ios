//
//  CalculationsView.swift
//  SplitBill
//
//  Created by Dmitrii Vasilev on 2024-12-10.
//

import SwiftUI
import SwiftData

struct CalculationsView: View {
    @Query var groups: [Group]
    @State private var searchCalculations: String = ""
    
    var filteredCalculations: [Group] {
        if searchCalculations.isEmpty {
            return groups
        }else{
            return groups.filter{$0.name.localizedCaseInsensitiveContains(searchCalculations)}
        }
    }
    var body: some View {
        NavigationStack{
            List(filteredCalculations){group in
                NavigationLink(group.name){
                    GroupCalculationsView(group: group)
                }
            }
            .navigationTitle("Calculations")
        }
        .searchable(text: $searchCalculations)
    }
}

#Preview {
    CalculationsView()
}
