//
//  ChecklistsView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ChecklistsView: View {
    
    
    @Environment(ChecklistsStore.self) private var checklistsStore
    @State var selectedList: ChecklistModel?
    var department: DepartmentModel
    
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(checklistsStore.checklists) { checklist in
                    checklistRow(checklist)
                    .swipeActions(edge: .trailing) {
                        deleteSwipeButton
                    }
                    .swipeActions(edge: .leading) {
                        editSwipeButton(checklist)
                    }
                }
                .onMove(perform: move)
            }
            .navigationTitle("\(department.title)")
            .sheet(item: $selectedList) { checklist in
                ChecklistEditSheet(checklist: checklist)
            }
            .toolbar {
                trailingToolbar
            }
        }
        .onAppear {
            checklistsStore.fetchChecklists(for: department)
        }
    }
    
}

// MARK: - Extracted Views
// ———————————————————————

extension ChecklistsView {
    
    /// Checklist Row
    ///
    private func checklistRow(_ checklist: ChecklistModel) -> some View {
        NavigationLink(destination: ChecklistDetailView(checklist: checklist)) {
            Text(checklist.title)
        }
    }
    
    /// Delete Swipe Button
    ///
    private var deleteSwipeButton: some View {
        Button(role: .destructive) {
            // TODO: -
            print("Deleting checklist")
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
    }
    
    /// Edit Swipe Button
    ///
    private func editSwipeButton(_ checklist: ChecklistModel) -> some View {
        Button() {
            selectedList = checklist
        } label: {
            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
        }
        .tint(.blue)
    }
    
}


// MARK: - Toolbar Content
// ———————————————————————

extension ChecklistsView {
    @ToolbarContentBuilder
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                checklistsStore.checklists.append(
                    ChecklistModel(
                        title: "New Checklist",
                        notes: "",
                        lines: []
                    )
                )
            } label: {
                Image(systemName: "plus.circle")
            }
        }
    }
}
    
    
// MARK: - Methods
// ————————————————

extension ChecklistsView {
    
    func move(from: IndexSet, to: Int) {
        checklistsStore.checklists.move(fromOffsets: from, toOffset: to)
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    ChecklistsView(department: DepartmentModel.samples[Int.random(in: 0..<4)])
        .environment(ChecklistsStore())
}
