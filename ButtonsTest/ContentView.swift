//
//  ContentView.swift
//  ButtonsTest
//
//  Created by Wontai Ki on 1/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var offsetY: CGFloat = .zero
    let buttonCount = 20
    let buttonHeight: CGFloat = 30
    let spacing: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { reader in
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: geometry.size.height)
                        ForEach(0 ..< buttonCount, id: \.self ) { index in
                            HStack(spacing: spacing) {
                                Button("Button \(index)") {
                                    
                                }
                                .frame(height: buttonHeight)
                                .offset(x: getOffset(geometry: geometry, index: index))
                                Spacer()
                            }
                        }
                        Spacer()
                            .frame(height: geometry.size.height)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .onScrollGeometryChange(for: CGFloat.self) { geo in
                    geo.contentOffset.y
                } action: { oldValue, newValue in
                    offsetY = newValue
                }

            }
            .ignoresSafeArea()
        }
    }
    
    // Based on ellipsoidal equation.
    func getOffset(geometry: GeometryProxy, index: Int) -> CGFloat {
        let a = geometry.size.width
        let b = geometry.size.height
        let offset = offsetY - CGFloat(index) * (buttonHeight + spacing)
        
        let x = sqrt(a*a*(1 - (offset * offset) / (b * b)))
        return a - x
    }
    
}

#Preview {
    ContentView()
}
