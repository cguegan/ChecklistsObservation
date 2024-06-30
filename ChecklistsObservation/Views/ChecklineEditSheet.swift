//
//  ChecklineEditSheet.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ChecklineEditSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var checkline: ChecklineModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $checkline.title)
                    TextField("Action", text: $checkline.action)
                    TextField("Notes", text: $checkline.notes, axis: .vertical)
                    Toggle("Is Checked", isOn: $checkline.isChecked)
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
    ChecklineEditSheet(checkline: ChecklistModel.bridgeSamples.first!.lines.first!)
}
