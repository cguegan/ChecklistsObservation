//
//  ContentView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var checklistsStore = ChecklistsStore()
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        TabView {
            ForEach(DepartmentModel.samples) { department in
                ChecklistsView(department: department)
                    .environment(checklistsStore)
                    .tabItem {
                        Label(department.title, systemImage: department.icon)
                    }
            }
            
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    ContentView()
}
