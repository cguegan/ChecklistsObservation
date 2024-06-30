//
//  ChecklistModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import Observation

@Observable
class ChecklistModel: Identifiable {
    var id: String
    var title: String
    var notes: String
    var lines: [ChecklineModel]
    
    init(title: String, notes: String, lines: [ChecklineModel] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.notes = notes
        self.lines = lines
    }
}


