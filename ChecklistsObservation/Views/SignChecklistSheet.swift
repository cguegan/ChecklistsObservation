//
//  SignChecklistSheet.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 01/07/2024.
//

import SwiftUI

struct SignChecklistSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var locationManager = LocationManager()
    @State private var execChecklist = ExecListModel()
    @Bindable var checklist: ChecklistModel
    
    // Signin properties
    @State var isSigning: Bool = false
    @State var clearSignature: Bool = false
    @State var signatureImage: UIImage?
    @State var signaturePDF: Data?
    
    // MARK: - Main body
    // —————————————————
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemFill)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    signArea
                    nameAndPositionView
                    signButton
                    statisticsView
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Sign Checklist")
            .toolbar {
                trailingToolbar
            }
            .onAppear {
                locationManager.checkLocationAuthorization()
            }
        }
    }
}


// MARK: - Extracted Views
// ———————————————————————

extension SignChecklistSheet {
    
    /// Sign Area
    ///
    var signArea: some View {
        VStack(spacing: 16) {
            ZStack(alignment: isSigning ? .bottomTrailing: .center) {
                SignatureViewContainer(
                    clearSignature: $clearSignature,
                    signatureImage: $signatureImage,
                    pdfSignature: $signaturePDF
                )
                .disabled(!isSigning)
                .frame(height: 197)
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(topLeading: 9, topTrailing: 8)
                    ))

                
                if isSigning {
                    Button(action: {
                        clearSignature = true
                    }, label: {
                        HStack {
                            Text("Clear")
                                .font(.callout)
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 28)
                        .background(
                            Capsule()
                                .fill(.gray.opacity(0.2))
                        )
                    })
                    .offset(.init(width: -12, height: -12))
                } else {
                    Button(action: {
                        isSigning = true
                    }, label: {
                        VStack(alignment: .center, spacing: 0) {
                            Image(systemName: "signature")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                                .padding(8)
                            Text("Sign here")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    })
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 0)
        }
    }
    
    /// Name and position text field
    ///
    var nameAndPositionView: some View {
        VStack(spacing: 0) {
            TextField("Full Name", text: $execChecklist.signedBy)
                .padding(.vertical, 10)
                .padding(.bottom, 2)
                .padding(.leading)
                .background(.white)
//                .clipShape(
//                    RoundedRectangle(cornerRadius: 8               )
//                )
                .overlay {
                    Divider()
                        .padding(.leading)
                        .offset(y: -24)
                }
            
            TextField("Title", text: $execChecklist.position)
                .padding(.vertical, 10)
                .padding(.bottom, 2)
                .padding(.leading)
                .background(.white)
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(bottomLeading: 9, bottomTrailing: 8)
                    )
                )
                .overlay {
                    Divider()
                        .padding(.leading)
                        .offset(y: -24)
                }
        }
    }
    
    /// Sign Button
    ///
    var signButton: some View {
        Button() {
            print("DEBUG: Signing process ...")
            
            // Set Date
            execChecklist.signedDate = Date.now
            // Set Location
            if let coordinate = locationManager.lastKnownLocation {
                execChecklist.location = "Valid location"
                execChecklist.latitude = coordinate.latitude
                execChecklist.longitude = coordinate.longitude
            } else {
                execChecklist.location = "Unknown Location"
            }
            // set Json of checklist
            let data = try! JSONEncoder().encode(checklist)
            let str = String (decoding: data, as: UTF8.self)
            print(str)
            execChecklist.checklistJson = str
            // Signed -> true
            execChecklist.signed = true
            // Save to Firebase
            // Save to history
            // Create PDF
            
            // Save to firestore
            // Reset checklist
            for line in checklist.lines {
                line.isChecked = false
            }
            // Dismiss window
            dismiss()
        } label : {
            Label("Sign & Close", systemImage: "signature")
                .padding(.horizontal)
        }
        .buttonStyle(.borderedProminent)
        .padding(25)
        .disabled(!execChecklist.isValid)
        
    }
    
    /// Statistics
    ///
    var statisticsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Checklist title: \(checklist.title)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text("Date: \(execChecklist.signedDate.formatted())")
            Divider()
            
            if let coordinate = locationManager.lastKnownLocation {
                Text("Latitude: \(coordinate.latitude)")
                Divider()
                Text("Longitude: \(coordinate.longitude)")
            } else {
                Text("Unknown Location")
            }
            
                
        }
        .padding(.leading)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


// MARK: - Toolbar Content
// ———————————————————————

extension SignChecklistSheet {
    @ToolbarContentBuilder
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
                dismiss()
            }
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    SignChecklistSheet(checklist: ChecklistModel.deckSamples[0])

}
