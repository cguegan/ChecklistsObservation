//
//  Checklists+Samples.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation

extension ChecklistModel {
    
    static let samples: [ChecklistModel] = [
        ChecklistModel(title: "Passage Planning",
                       notes: "",
                       lines: [
                        ChecklineModel(title: "Sailing Directions",     action: "Checked"),
                        ChecklineModel(title: "Contingency Options",    action: "Checked"),
                        ChecklineModel(title: "Paper Charts",           action: "Updated"),
                        ChecklineModel(title: "Security Requirement",   action: "Checked"),
                        ChecklineModel(title: "Draft/Air Restrictions", action: "Checked"),
                        ChecklineModel(title: "Reporting Areas",        action: "Noted"),
                        ChecklineModel(title: "Pilotage Requirement",   action: "Checked"),
                        ChecklineModel(title: "Berth Requirements",     action: "Noted"),
                        ChecklineModel(title: "Safe Manning",           action: "Checked"),
                        ChecklineModel(title: "Fuel Consumption",       action: "Calculated")
                    ]),
        ChecklistModel(title: "Pre-Departure",
                       notes: "",
                       lines: [
                        ChecklineModel(title: "Local Pilot",            action: "Informed"),
                        ChecklineModel(title: "Departure Time",         action: "Confirmed"),
                        ChecklineModel(title: "Passage plan",           action: "Prepared"),
                        ChecklineModel(title: "Charts table",           action: "Ready"),
                        ChecklineModel(title: "Navigational warning",   action: "Latest"),
                        ChecklineModel(title: "weather forecast",       action: "Latest"),
                        ChecklineModel(title: "Deck Preparation",       action: "Prepared"),
                        ChecklineModel(title: "Stern, Garage Doors",    action: "Locked"),
                        ChecklineModel(title: "1 hour notice to E/R",   action: "Notified"),
                        ChecklineModel(title: "GPS",                    action: "Checked"),
                        ChecklineModel(title: "Daily Trip",             action: "Reseted"),
                        ChecklineModel(title: "ECDIS",                  action: "Started"),
                        ChecklineModel(title: "VHF Radio",              action: "Started"),
                        ChecklineModel(title: "Voice Check",            action: "Done"),
                        ChecklineModel(title: "VHF on port Ch",         action: "Set"),
                        ChecklineModel(title: "Internal com.",          action: "Checked"),
                        ChecklineModel(title: "Winches & windlass",     action: "Checked"),
                        ChecklineModel(title: "Fog horn",               action: "Tested"),
                        ChecklineModel(title: "Gyro headings",          action: "Checked"),
                        ChecklineModel(title: "Magnetic heading",       action: "Checked"),
                        ChecklineModel(title: "Bridge wing controls",   action: "Open"),
                        ChecklineModel(title: "Light on bridge",        action: "Checked",      notes: "if at night"),
                        ChecklineModel(title: "Navigation lights",      action: "On & checked", notes: "if at night"),
                        ChecklineModel(title: "All Crew",               action: "Noticed")
                   ]),
        ChecklistModel(title: "Departure",
                       notes: "To be executed before each departure, not more than one hour before.",
                       lines: [
                        ChecklineModel(title: "Crew",                   action: "Onboard"),
                        ChecklineModel(title: "Guests",                 action: "Onboard"),
                        ChecklineModel(title: "ECDIS at correct scale", action: "Set"),
                        ChecklineModel(title: "Radar at correct scale", action: "Set"),
                        ChecklineModel(title: "AIS  dest, ETA and PAX", action: "Set"),
                        ChecklineModel(title: "Guests and Crew",        action: "Onboard"),
                        ChecklineModel(title: "Echo sounder at scale",  action: "Checked"),
                        ChecklineModel(title: "Both rudder pumps",      action: "Started"),
                        ChecklineModel(title: "Steering",               action: "Tested"),
                        ChecklineModel(title: "CCTV view",              action: "Set"),
                        ChecklineModel(title: "Power on generators",    action: "Online"),
                        ChecklineModel(title: "Stabilisers",            action: "Centered"),
                        ChecklineModel(title: "Main Engines",           action: "Started"),
                        ChecklineModel(title: "Engine controls",        action: "On the bridge"),
                        ChecklineModel(title: "Bow thrusters",          action: "Started"),
                        ChecklineModel(title: "Bow thruster",           action: "Tested")
                   ])
    ]
    
}
