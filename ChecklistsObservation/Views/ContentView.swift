//
//  ContentView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var checklistsStore: ChecklistsStore = ChecklistsStore()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(checklistsStore.checklists) { checklist in
                    NavigationLink(destination: ChecklistDetailView(checklist: checklist)) {
                        Text(checklist.title)
                    }
                }
                .navigationTitle("Checklists")
            }
        }
    }
}



#Preview {
    ContentView()
}
