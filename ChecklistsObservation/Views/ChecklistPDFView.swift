//
//  ChecklistPDFView.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 01/07/2024.
//

import SwiftUI

@MainActor
struct ChecklistPDFView: View {
    
    var checklist: ChecklistModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            pdfView
            ShareLink("Export PDF", item: render())
        }
        
    }
}


// MARK: - Extracted Views
// ———————————————————————

extension ChecklistPDFView {
    
    /// PDF View
    ///
    var pdfView: some View {
        VStack {
            header
            rectSpacer
            VStack(spacing: 0) {
                checklistTitle
                infoSection
                lines
            }
            .frame(maxWidth: .infinity)
            .border(Color.black)
            rectSpacer
            signature
            rectPusher
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .padding(.horizontal, 60)
        .frame(width:  PDFConstants.pageWidth*PDFConstants.dotsPerInch,
               height: PDFConstants.pageHeight*PDFConstants.dotsPerInch )
    }
    
    /// Header
    ///
    var header: some View {
        // Header
        HStack {
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            
            VDivider()
            
            Text("Machinery Checklists".uppercased())
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading)
                .frame(width: 250, alignment: .center)
            
            VDivider()
            
            
            Text("\(checklist.title)")
                .font(.system(size: 7))
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .border(Color.black)
    }
    
    /// Rectangle Spacer
    var rectSpacer: some View {
        Rectangle()
            .foregroundColor(Color.clear)
            .frame(height: 10)
    }
    
    /// Checklist Title
    var checklistTitle: some View {
        Group {
            Text(checklist.title)
                .font(.system(size: 14))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            HDivider()
        }
    }
    
    /// Info Section
    var infoSection: some View {
        Group {
            HStack {
                Text("LOCATION")
                    .font(.system(size: 9))
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .trailing)
                
                VDivider().frame(height: 16)

                Text("Monaco")
                    .font(.system(size: 9))
                    .frame(width: 120, alignment: .leading)
                
                VDivider().frame(height: 16)

                Text("DATE")
                    .font(.system(size: 9))
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .trailing)
                
                VDivider().frame(height: 16)

                Text(Date(), style: .date)
                    .padding(0)
                    .font(.system(size: 10))
                    .frame(width: 120, alignment: .leading)
            }
            
            HDivider()
        }
    }
    
    /// Lines
    var lines: some View {
        ForEach(checklist.lines) { line in
            
            if line.type == .sectionTitle {
                Text("\(line.title.uppercased())")
                    .font(.system(size: 9))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.vertical, 3)
                
            } else if line.type == .checkline {
                HStack(spacing: 0) {
                    Text(String(format: "%02d", line.ordering))
                        .font(.system(size: 9))
                        .frame(maxWidth: 15, alignment: .leading)
                        .padding(.leading)
                    
                    VDivider().frame(height: 16)
                    
                    Text("\(line.title)")
                        .font(.system(size: 9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    VDivider().frame(height: 16)

                    Text("\(line.action.uppercased())")
                        .font(.system(size: 9))
                        .bold()
                        .frame(width: 100, alignment: .leading)
                        .padding(.leading)
                    
                    VDivider().frame(height: 16)

                    Text(Date(), style: .time)
                        .font(.system(size: 9))
                        .bold()
                        .frame(width: 60)
                        .padding(.leading)
                }
                
            } else if line.type == .comment {
                Text("\(line.title): \(line.notes)")
                    .font(.system(size: 9))
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.vertical, 3)
            }
            
            HDivider()
        }
    }
    
    /// Rectangle Pusher
    var rectPusher: some View {
        Rectangle()
            .foregroundColor(Color.clear)
    }
    
    /// Signature
    var signature: some View {
        HStack(alignment: .top) {
            Text("Signed by")
                .font(.system(size: 9))
                .padding(10)
            
            VDivider()
            
            VStack(alignment: .leading) {
                Text("Christophe Guegan")
                    .font(.system(size: 9))
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .bold()
                
                Text("Captain")
                    .font(.system(size: 9))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
            }
            
            VDivider()
            
            Rectangle()
                .foregroundColor(.clear)
        }
        .frame(maxWidth: .infinity)
//        .frame(height: 40)
        .border(Color.black)
    }
}


// MARK: - Methods
// ———————————————

extension ChecklistPDFView {
    
    /// Render PDF
    func render() -> URL {
        // 1: Render Hello World with some modifiers
        let renderer = ImageRenderer(content: pdfView)
        
        // 2: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: "output.pdf")
        
        // 3: Start the rendering process
        renderer.render { size, context in
            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
            var box = CGRect( x: 0, y: 0, 
                              width:  PDFConstants.pageWidth*PDFConstants.dotsPerInch,
                              height: PDFConstants.pageHeight*PDFConstants.dotsPerInch )
            
            // 5: Create the CGContext for our PDF pages
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)
            
            // 7: Render the SwiftUI view data onto the page
            context(pdf)
            
            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    let checklist = ChecklistModel.bridgeSamples[1]
    checklist.setOrder()
    return ChecklistPDFView(checklist: checklist)
}


struct HDivider: View {
    let color: Color = .black
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
struct VDivider: View {
    let color: Color = .black
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
struct PDFConstants {
    static let dotsPerInch: CGFloat = 72.0
    static let pageWidth: CGFloat   = 8.5        // 72 x 8.5 = 612
    static let pageHeight: CGFloat  = 11.0
}
