//
//  Color+Extensions.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 04/07/2024.
//  https://www.youtube.com/watch?v=gnpdxCO4ue4&list=PLDMXqpbtInQgFOoRkbRnMHEAyJs3qB8Dm&index=2
//

import Foundation
import SwiftUI

// Extension to add functionality to the Color struct
extension Color {
    
    // Function to convert a Color to its hexadecimal string representation
    func toHex() -> String? {
        // Convert Color to UIColor to access its components
        let uic = UIColor(self)
        
        // Ensure that the color has at least 3 components (RGB)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        // Extract the red, green, and blue components
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        // Default alpha value is 1.0 (fully opaque)
        var a = Float(1.0)
        
        // If there are 4 components, set the alpha value accordingly
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        // If alpha is not fully opaque, include it in the hex string
        if a != Float(1.0) {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255.0), lroundf(g * 255.0), lroundf(b * 255.0), lroundf(a * 255.0))
        } else {
            // Otherwise, return hex string without alpha
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255.0), lroundf(g * 255.0), lroundf(b * 255.0))
        }
    }
    
    // Initializer to create a Color from a hexadecimal string
    init(hex: String) {
        // Remove '#' if it exists at the start of the string
        var cleanedHex = hex
        if cleanedHex.hasPrefix("#") {
            cleanedHex = String(cleanedHex.dropFirst())
        }
        
        // Convert hex string to an integer
        var rgb: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&rgb)
        
        // Extract red, green, and blue components from the integer
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        // Initialize the Color with the extracted RGB values
        self.init(red: red, green: green, blue: blue)
    }
}
