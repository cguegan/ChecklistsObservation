//
//  ChecklistsView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI

struct ChecklistsView: View {
    
    @State var checklistsStore: ChecklistsStore = ChecklistsStore()
    @State var selectedList: ChecklistModel?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(checklistsStore.checklists) { checklist in
                    NavigationLink(destination: ChecklistDetailView(checklist: checklist)) {
                        Text(checklist.title)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            print("Deleting checklist")
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button() {
                            selectedList = checklist
                        } label: {
                            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("Checklists")
            .sheet(item: $selectedList) { checklist in
                ChecklistEditSheet(checklist: checklist)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        checklistsStore.checklists.append(ChecklistModel(title: "New Checklist", notes: "", lines: []))
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
    
    func move(from: IndexSet, to: Int) {
        checklistsStore.checklists.move(fromOffsets: from, toOffset: to)
    }
}

#Preview {
    ChecklistsView()
}
