//
//  ChecklistDetailView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ChecklistDetailView: View {
    
    var checklist: ChecklistModel
    @State var selectedLine: ChecklineModel?
    
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        NavigationStack {
            List {
                notesView
                ForEach (checklist.lines) { line in
                    checklineRow(line)
                    .swipeActions(edge: .trailing) {
                        deleteSwipeButton(line)
                    }
                    .swipeActions(edge: .leading) {
                        editSwipeButton(line)
                    }
                }
                .onMove(perform: move)
            }
            .navigationTitle("\(checklist.title)")
            .sheet(item: $selectedLine) { line in
                ChecklineEditSheet(checkline: line)
            }
            .toolbar {
                trailingToolbar
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
    private func checklineRow(_ line: ChecklineModel) -> some View {
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
    }
    
    /// Delete Swipe Button
    ///
    private func deleteSwipeButton(_ line: ChecklineModel) -> some View {
        Button(role: .destructive) {
            delete(line)
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
    }
    
    /// Edit Swipe Button
    private func editSwipeButton(_ line: ChecklineModel) -> some View {
        Button() {
            selectedLine = line
        } label: {
            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
        }
        .tint(.blue)
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
            CircularProgressView(progress: checklist.completionState, lineWidth: 1.8)
                .frame(width: 20, height: 20)
                .onTapGesture {
                    withAnimation {
                        self.reset()
                    }
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
        if let index = checklist.lines.firstIndex( where: { $0.id == line.id } ) {
            print("Deleting checkline \(checklist.lines[index].title)")
            checklist.lines.remove(at: index)
        }
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    ChecklistDetailView(checklist: ChecklistModel.bridgeSamples[1])
}
