//
//  SeetingsView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 06/07/2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    @State var checklistsStore = ChecklistsStore()
    @State var allowEditing: Bool = true
    @Query(sort: \DepartmentModel.order) private var departments: [DepartmentModel]
    
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Yacht details") {
                    Text("Mimtee")
                    Text("9771418")
                    Button("Change PIN Code") {
                        // Change pin code
                    }
                    Toggle("Allow editing", isOn: $allowEditing)
                }
                
                Section {
                    ForEach ( departments ) { department in
                        Label(department.title, systemImage: department.icon)
                    }
                } header: {
                    Text("Departments")
                } footer: {
                    Text("A maximum of 4 department is currently allowed.")
                }
            }
            .navigationTitle("Settings")
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    SettingsView()
        .modelContainer(previewContainer)
        .environment(ChecklistsStore())

}
