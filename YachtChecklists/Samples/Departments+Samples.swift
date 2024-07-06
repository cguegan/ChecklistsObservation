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
                        order: 0,
                        checklists: ChecklistModel.emergencySamples),
        // Bridge
        DepartmentModel(title: "Bridge",
                        icon:"binoculars",
                        order: 1,
                        checklists: ChecklistModel.bridgeSamples),
        // Machinery
        DepartmentModel(title: "Machinery",
                        icon:"wrench.adjustable",
                        order: 2,
                        checklists: ChecklistModel.machinerySamples),
        // Deck
//        DepartmentModel(title: "Deck",
//                        icon: "lifepreserver",
//                        order: 3,
//                        checklists: ChecklistModel.deckSamples),
        // Interior
//        DepartmentModel(title: "Interior",
//                        icon:"bed.double", 
//                        order: 4,
//                        checklists: ChecklistModel.interiorSamples)
        ]
        
    
}
