//
//  ChecklistsView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI
import SwiftData

struct ChecklistsView: View {
    
    @Environment(ChecklistsStore.self) private var checklistsStore
    
    @State var selectedList: ChecklistModel?
    @State var deletableList: ChecklistModel?
    @State var confirmDelete: Bool = false
    
    let department: DepartmentModel
    var checklists: [ChecklistModel] {
        return department.checklists.sorted { $0.order < $1.order }
    }
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(checklists) { checklist in
                    checklistRow(checklist)
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
            .confirmationDialog("Confirmation", isPresented: $confirmDelete) {
                confirmDeleteButton
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
    private func checklistRow(_ list: ChecklistModel) -> some View {
        NavigationLink(destination: ChecklistDetailView(checklist: list)) {
            Text(list.title)
        }
        .swipeActions(edge: .trailing) {
            deleteSwipeButton(list)
        }
        .swipeActions(edge: .leading) {
            editSwipeButton(list)
        }
    }
    
    /// Delete Swipe Button
    ///
    private func deleteSwipeButton(_ list: ChecklistModel) -> some View {
        Button() {
            deletableList = list
            confirmDelete = true
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
        .tint(.red)
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
    
    /// Confirm Delete Button
    ///
    private var confirmDeleteButton: some View {
        Button("Confirm Delete", role: .destructive) {
            if let list = deletableList {
                withAnimation {
                    delete(list)
                }
            }
        }
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
                        order: department.checklists.count,
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
    
    func delete(_ list: ChecklistModel) {
        print("DEBUG: Deleting checklist \(list.title)...")
        if let index = checklistsStore.checklists.firstIndex( where: { $0.id == list.id } ) {
            checklistsStore.checklists.remove(at: index)
            self.deletableList = nil
            print("DEBUG: Deleting done")
        } else {
            print("ERROR: Could not find \(list.title) in department \(department.title). while deleting the list")
        }
    }
    
}


// MARK: - Preview
// ———————————————

struct ChecklistsViewContainer: View {
    
    @Query(sort: \DepartmentModel.order) private var departments: [DepartmentModel]
    
    var body: some View {
        ChecklistsView(department: departments[1])
    }
}

#Preview { @MainActor in
    ChecklistsViewContainer()
        .modelContainer(previewContainer)
        .environment(ChecklistsStore())
}
