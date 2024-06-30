//
//  ChecklistsStore.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import Observation

@Observable
class ChecklistsStore {
    var checklists: [ChecklistModel] = []
    
    init() {
        self.fetchChecklists()
    }
    
    func fetchChecklists() {
        self.checklists = ChecklistModel.samples
    }
    
}
