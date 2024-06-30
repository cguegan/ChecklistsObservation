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
    
    var body: some View {
        NavigationStack {
            List {
                if !checklist.notes.isEmpty {
                    Text(checklist.notes)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                
                ForEach (checklist.lines) { line in
                    HStack (alignment: .top) {
                        
                        Image(systemName: line.isChecked ? "checkmark.square" : "square")
                            .font(.title3)
                            .foregroundColor(line.isChecked ? .accentColor: .gray)
                            .onTapGesture {
                                line.isChecked.toggle()
                            }
                        
                            VStack(alignment: .leading) {
                                Text(line.title)
                                    .foregroundColor(line.isChecked ? .secondary : .primary)
                                if !line.notes.isEmpty {
                                    Text(line.notes)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            
                            
                            Spacer()
                            Text("\(line.action)".uppercased())
                                .font(.caption)
                                .bold(line.isChecked)
                                .foregroundColor(line.isChecked ? .accentColor : .secondary)
                                .padding(.top, 4)
                        
                        
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            print("Deleting checkline")
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button() {
                            selectedLine = line
                        } label: {
                            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                        }
                        .tint(.blue)
                    }
                }
                .onMove(perform: move)

            }
            .navigationTitle("\(checklist.title)")
            .sheet(item: $selectedLine) { line in
                    ChecklineEditSheet(checkline: line)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        checklist.lines.append(ChecklineModel(title: "New item", action: "Checked"))
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
    
    func move(from: IndexSet, to: Int) {
        checklist.lines.move(fromOffsets: from, toOffset: to)
    }
    
}

#Preview {
    ChecklistDetailView(checklist: ChecklistModel.bridgeSamples[1])
}
