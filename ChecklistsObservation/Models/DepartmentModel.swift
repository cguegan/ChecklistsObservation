//
//  DepartmentModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import Observation

@Observable
class DepartmentModel: Identifiable, Codable {
    var id: String
    var title: String
    var icon: String
    var checklists: [ChecklistModel]
    
    init(title: String, icon: String, checklists: [ChecklistModel]) {
        self.id = UUID().uuidString
        self.title = title
        self.icon = icon
        self.checklists = checklists
    }
}
