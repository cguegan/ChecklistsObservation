//
//  ChecklistEditSheet.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ChecklistEditSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var checklist: ChecklistModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Checklist")) {
                    TextField("Checklist title", text: $checklist.title)
                    TextField("Notes", text: $checklist.notes)
                }
                
                Section(header: Text("Statistics")) {
                    HStack {
                        Text("Checked:")
                        Spacer()
                        Text("12 times")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Last executed:")
                        Spacer()
                        Text(Date.now.formatted(date: .abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Number of checklines:")
                        Spacer()
                        Text("\(checklist.lines.count)")
                            .foregroundStyle(.secondary)
                    }
                
                }
            }
            .navigationTitle("Edit Checkline")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ChecklistEditSheet(checklist: ChecklistModel.samples.first!)
}
