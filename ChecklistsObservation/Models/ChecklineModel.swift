//
//  ChecklineModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import Observation

@Observable
class ChecklineModel: Identifiable {
    var id: String
    var title: String
    var action: String
    var notes: String
    var isChecked: Bool
    
    init(title: String, action: String, notes: String = "") {
        self.id = UUID().uuidString
        self.title = title
        self.action = action
        self.notes = notes
        self.isChecked = false
    }
    
}
