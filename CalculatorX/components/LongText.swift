//
//  LongText.swift
//  CalculatorX
//
//  Created by HauNguyen on 04/10/2565 BE.
//

import SwiftUI

struct LongText: View {

    /* Indicates whether the user want to see all the text or not. */
    @State private var expanded: Bool = false

    /* Indicates whether the text has been truncated in its display. */
    @State private var truncated: Bool = false

    private var text: String
    
    private var lineLimit: Int = 3
    
    @Environment(\.colorScheme) private var colorScheme

    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    init(_ text: String) {
        self.text = text
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        // Calculate the bounding box we'd need to render the
        // text given the width from the GeometryReader.
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(self.text)
                .font(.regular(size: 14))
                .foregroundColor(self.systemColor)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(self.lineLimit)
                // see https://swiftui-lab.com/geometryreader-to-the-rescue/,
                // and https://swiftui-lab.com/communicating-with-the-view-tree-part-1/
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })

            
            if self.truncated {
                self.toggleButton
            }
        }
    }
    
    var systemColor: Color {
        return self.colorScheme == .dark ? Color.white : Color.black
    }

    var toggleButton: some View {
        CustomContextMenu {
            Button(action: { self.expanded.toggle() }) {
                Text(self.expanded ? "Show less" : "Show more")
                    .font(.caption)
            }
        } preview: {
            Text(self.text)
                .font(.regular(size: 14))
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
        }


    }

}

struct LongText_Previews: PreviewProvider {
    static var previews: some View {
        LongText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    }
}
