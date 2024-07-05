//
//  DepartmentModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import SwiftData

@Model
class DepartmentModel: Identifiable, Codable {
    
    var id: String = ""
    var title: String = ""
    var icon: String = ""
    var order: Int = 0
    
    @Relationship(deleteRule: .cascade)
    var checklists: [ChecklistModel] = []
    
    init(title: String, icon: String, order: Int , checklists: [ChecklistModel]) {
        self.id = UUID().uuidString
        self.title = title
        self.icon = icon
        self.order = order
        self.checklists = checklists
    }

    // Make department model codable
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _title = "title"
        case _icon = "icon"
        case _order = "order"
        case _checklists = "checklists"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: ._id)
        title = try container.decode(String.self, forKey: ._title)
        icon = try container.decode(String.self, forKey: ._icon)
        order = try container.decode(Int.self, forKey: ._order)
        checklists = try container.decode([ChecklistModel].self, forKey: ._checklists)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(title, forKey: ._title)
        try container.encode(icon, forKey: ._icon)
        try container.encode(order, forKey: ._order)
        try container.encode(checklists, forKey: ._checklists)
    }
    
}
