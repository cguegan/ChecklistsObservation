//
//  ContentView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var checklistsStore = ChecklistsStore()
    @Query(sort: \DepartmentModel.order) private var departments: [DepartmentModel]
    
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        TabView {
            ForEach(departments) { department in
                ChecklistsView(department: department)
                    .environment(checklistsStore)
                    .tabItem {
                        Label(department.title, systemImage: department.icon)
                    }
            }
            
            SettingsView()
                .environment(checklistsStore)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview { @MainActor in
    ContentView()
        .modelContainer(previewContainer)
}
