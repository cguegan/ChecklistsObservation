//
//  CircularProgressBarView.swift
//  iChecks
//
//  Created by Christophe Guégan on 24/02/2024.
//

import SwiftUI

struct CircularProgressView: View {
    private let progress: Double
    private let showPercent: Bool
    private let lineWidth: Double
    
    init(progress: Double, showPercent: Bool = false, lineWidth: Double = 1.5) {
        self.progress = progress
        self.showPercent = showPercent
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth))
            
            Circle()
                .trim(from: 0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
            
            if showPercent {
                Text("\(Int(progress * 100))%")
                    .font(.title3)
            }
        }
    }
}

#Preview {
    VStack {
        CircularProgressView(progress: 0.7, lineWidth: 3)
            .frame(width: 24, height: 24)
        
        CircularProgressView(progress: 0.7, lineWidth: 6)
            .frame(width: 48, height: 48)
    }
    
}
