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
    
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        NavigationStack {
            Form {
                checklistDataSection
                statisticsSection
            }
            .navigationTitle("Edit Checklist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                trailingToolbar
            }
        }
    }
}


// MARK: - Extracted Views
// ———————————————————————

extension ChecklistEditSheet {
    
    /// Checklist Data Section
    ///
    var checklistDataSection: some View {
        Section(header: Text("Checklist")) {
            TextField("Checklist title", text: $checklist.title)
            TextField("Notes", text: $checklist.notes, axis: .vertical)
        }
    }
    
    /// Statistic Section
    ///
    var statisticsSection: some View {
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
    
}


// MARK: - Toolbar Content
// ———————————————————————

extension ChecklistEditSheet {
    @ToolbarContentBuilder
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
                dismiss()
            }
        }
    }
}
    

// MARK: - Preview
// ———————————————

#Preview {
    ChecklistEditSheet(checklist: ChecklistModel.bridgeSamples.first!)
}
