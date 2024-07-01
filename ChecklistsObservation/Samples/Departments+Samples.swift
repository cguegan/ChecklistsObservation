//
//  Departments+Samples.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation

extension DepartmentModel {
    
    static let samples: [DepartmentModel] = [
        // Emergency
        DepartmentModel(title: "Emergency",
                        icon:"bolt.circle",
                        checklists: ChecklistModel.emergencySamples),
        // Bridge
        DepartmentModel(title: "Bridge",
                        icon:"binoculars",
                        checklists: ChecklistModel.bridgeSamples),
        // Machinery
        DepartmentModel(title: "Machinery",
                        icon:"wrench.adjustable",
                        checklists: ChecklistModel.machinerySamples),
        // Deck
        DepartmentModel(title: "Deck",
                        icon: "lifepreserver",
                        checklists: ChecklistModel.deckSamples),
        // Interior
        DepartmentModel(title: "Interior",
                        icon:"bed.double",
                        checklists: ChecklistModel.interiorSamples)
        ]
        
    
}
