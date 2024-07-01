//
//  ExecListModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 01/07/2024.
//

import Foundation

struct ExecListModel: Identifiable, Codable {
    var id:             String = UUID().uuidString
    var checklistID:    String = ""
    var title:          String = ""
    var location:       String = ""
    var latitude:       Double = 0.0
    var longitude:      Double = 0.0
    var checklistJson:  String = ""
    var signed:         Bool = false
    var signature:      String = ""
    var signedDate:     Date = .now
    var signedBy:       String = ""
    var position:       String = ""
    var pdfUrl:         String = ""
    
    
    var isValid: Bool {
        return !signedBy.isEmpty && !position.isEmpty
    }
}
