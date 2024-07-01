//
//  ChecklistDetailView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ChecklistDetailView: View {
    
    @State private var selectedLine: ChecklineModel?
    @State private var deletableLine: ChecklineModel?
    @State private var confirmDelete: Bool = false
    @State private var signChecklist: Bool = false
    
    var checklist: ChecklistModel
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        NavigationStack {
            List {
                notesView
                Text("Completion state: \(checklist.completionState)")
                ForEach (checklist.lines) { line in
                    checklineRow(line)
                }
                .onMove(perform: move)
            }
            .navigationTitle("\(checklist.title)")
            .sheet(item: $selectedLine) { line in
                ChecklineEditSheet(checkline: line)
            }
            .fullScreenCover(isPresented: $signChecklist) {
                SignChecklistSheet(checklist: checklist)
            }
            .toolbar {
                trailingToolbar
            }
            .confirmationDialog("Confirmation", isPresented: $confirmDelete) {
                confirmDeleteButton
            }
            
        }
    }
}


// MARK: - Extracted Views
// ———————————————————————

extension ChecklistDetailView {
    
    /// Notes view
    ///
    private var notesView: some View {
        Group {
            if !checklist.notes.isEmpty {
                Text(checklist.notes)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    /// Checkline Row
    ///
    @ViewBuilder
    private func checklineRow(_ line: ChecklineModel) -> some View {
        switch line.type {
        case .checkline:
            AnyView(checkableLine(line))
        case .sectionTitle:
            AnyView(sectionTitleRow(line))
        case .comment:
            AnyView(commentRow(line))
        }
    }
    
    /// Checkable line item
    ///
    private func checkableLine(_ line: ChecklineModel) -> some View {
        HStack (alignment: .top) {
            
            // Icon
            Image(systemName: line.isChecked ? "checkmark.square" : "square")
                .font(.title3)
                .foregroundColor(line.isChecked ? .accentColor: .gray)
            
            VStack(alignment: .leading) {
                // Title
                Text(line.title)
                    .foregroundColor(line.isChecked ? .secondary : .primary)
                // Notes
                if !line.notes.isEmpty {
                    Text(line.notes)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            // Action
            Text("\(line.action)".uppercased())
                .font(.caption)
                .bold(line.isChecked)
                .foregroundColor(line.isChecked ? .accentColor : .secondary)
                .padding(.top, 4)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            line.isChecked.toggle()
        }            
        .swipeActions(edge: .trailing) {
            deleteSwipeButton(line)
        }
        .swipeActions(edge: .leading) {
            editSwipeButton(line)
        }
    }
    
    private func sectionTitleRow(_ line: ChecklineModel)  -> some View {
        HStack {
            // Icon
            Image(systemName: "line.3.horizontal")
                .font(.title3)
            
            // Title
            Text(line.title.uppercased())
                .foregroundColor(line.isChecked ? .secondary : .primary)
                .bold()
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .listRowBackground(Color.gray.opacity(0.1))
        .listRowSeparator(.hidden)
        .swipeActions(edge: .trailing) {
            deleteSwipeButton(line)
        }
        .swipeActions(edge: .leading) {
            editSwipeButton(line)
        }
    }
    
    private func commentRow(_ line: ChecklineModel)  -> some View {
        HStack(alignment: .top) {
            // Icon
            Image(systemName: "info.circle")
                .font(.title3)
                .foregroundStyle(.secondary.opacity(0.5))
            
            VStack {
                // Title
                Text("**\(line.title)**: *\(line.notes)*")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
            .swipeActions(edge: .trailing) {
                deleteSwipeButton(line)
            }
            .swipeActions(edge: .leading) {
                editSwipeButton(line)
            }
    }

    /// Delete Swipe Button
    /// Display a trash button whenever the user swap left
    ///
    private func deleteSwipeButton(_ line: ChecklineModel) -> some View {
        Button() {
            deletableLine = line
            confirmDelete = true
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
        .tint(.red)
    }
    
    /// Edit Swipe Button
    ///
    private func editSwipeButton(_ line: ChecklineModel) -> some View {
        Button() {
            selectedLine = line
        } label: {
            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
        }
        .tint(.blue)
    }
    
    /// Confirm Delete Button
    ///
    private var confirmDeleteButton: some View {
        Button("Confirm Delete", role: .destructive) {
            if let line = deletableLine {
                withAnimation {
                    delete(line)
                }
            }
        }
    }
    
}


// MARK: - Toolbar Content
// ———————————————————————

extension ChecklistDetailView {
    @ToolbarContentBuilder
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                checklist.lines.append(
                    ChecklineModel(
                        title: "New item",
                        action: "Checked"
                    )
                )
            } label: {
                Image(systemName: "plus.circle")
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            if checklist.completionState < 1.0 {
                CircularProgressView(progress: checklist.completionState, lineWidth: 1.8)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        withAnimation {
                            self.reset()
                        }
                    }
                    .padding(.leading, 17)
            } else {
                Button {
                    signChecklist = true
                } label: {
                    Label("Check done", systemImage: "checkmark.circle")
                }
                .tint(.green)
                .padding(.leading, 0)
            }
        }
    }
}


// MARK: - Methods
// ———————————————

extension ChecklistDetailView {
    
    func reset() {
        for line in checklist.lines {
            line.isChecked = false
        }
    }
    
    func move(from: IndexSet, to: Int) {
        checklist.lines.move(fromOffsets: from, toOffset: to)
    }
    
    func delete(_ line: ChecklineModel) {
        print("DEBUG: Deleting checkline \(line.title)")
        if let index = checklist.lines.firstIndex( where: { $0.id == line.id } ) {
            checklist.lines.remove(at: index)
            self.deletableLine = nil
            print("DEBUG: Deleting done")
        }  else {
            print("ERROR: Could not find \(line.title) in checklist \(checklist.title) while deleting the line")
        }
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    ChecklistDetailView(checklist: ChecklistModel.emergencySamples[0])
}
