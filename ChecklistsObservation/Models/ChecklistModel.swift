//
//  ChecklistModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import SwiftData

@Model
class ChecklistModel: Identifiable, Codable {
    var id: String = ""
    var title: String = ""
    var notes: String = ""
    var order: Int = 0
    
    @Relationship(deleteRule: .cascade)
    var lines: [ChecklineModel]
    
    init(title: String, notes: String, order: Int, lines: [ChecklineModel] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.notes = notes
        self.order = order
        self.lines = lines
    }
    
    // Make checklist model codable
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _title = "title"
        case _notes = "notes"
        case _order = "order"
        case _lines = "lines"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: ._id)
        title = try container.decode(String.self, forKey: ._title)
        notes = try container.decode(String.self, forKey: ._notes)
        order = try container.decode(Int.self, forKey: ._order)
        lines = try container.decode([ChecklineModel].self, forKey: ._lines)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(title, forKey: ._title)
        try container.encode(notes, forKey: ._notes)
        try container.encode(order, forKey: ._order)
        try container.encode(lines, forKey: ._lines)
    }
    
    // Set the order of lines
    
    func setOrder() {
        var order = 1
        for line in lines {
            if line.type == .checkline {
                line.order = order
                order += 1
            }
        }
    }
    
}

// MARK: - Computed properties
// ———————————————————————————

extension ChecklistModel {
    
    // Return the number of currently checked checklines
    var itemChecked: Int {
        let checkedCount = lines.reduce(0) { $0 + $1.counting }
        return checkedCount
    }
    
    // Return the number of checkline
    var totalCheckinesNbr: Int {
        let linesCount = lines.reduce(0) { checklinesCount, line in
            if line.type == .checkline {
                return checklinesCount + 1
            } else {
                return checklinesCount
            }
        }
        return linesCount
    }
    
    // Return the completion state as a double value from 0.0 to 1.0
    var completionState: Double {
        if itemChecked > 0 {
            return Double(itemChecked) / Double(totalCheckinesNbr)
        } else {
            return 0.0
        }
    }
    
}


