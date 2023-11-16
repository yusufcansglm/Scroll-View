//
//  SwiftUwqIView.swift
//  DesignCode
//
//  Created by Yusuf Can Sağlam on 10.11.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            VStack {
             
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(carddData) { item in
                            GeometryReader { geometry in
                                CarddView(card: item)
                                    .padding()
                                    .rotation3DEffect(
                                        Angle(degrees:
                                                geometry.frame(in: .global).minX  / -17
                                            ),
                                                              axis: (x: 1.0, y: 9.0, z: -1.0)
                                    )
                                
                            }.frame(width: 330,height: 300)
                        }
                        
                        
                    }.scrollTargetLayout()
                }.scrollTargetBehavior(.viewAligned)
                
                    
            }
        
    }
}

#Preview {
    ContentView()
}

struct Cardd: Identifiable {
    var id = UUID()
    var coursetitle: String
    var courseContent: String
    var lastupdate: String
    var arkaplanren1: Color
    var arkaplanrenk2: Color
}

let carddData = [
    Cardd(id: UUID(), coursetitle: "Swift Programming", courseContent: "Learn Swift programming language.", lastupdate: "2023-11-10", arkaplanren1: .red, arkaplanrenk2: .blue),
    Cardd(id: UUID(), coursetitle: "iOS Development", courseContent: "Build iOS applications with Swift.", lastupdate: "2023-11-10", arkaplanren1: .green, arkaplanrenk2: .yellow),
    Cardd(id: UUID(), coursetitle: "Data Structures", courseContent: "Study fundamental data structures.", lastupdate: "2023-11-10", arkaplanren1: .purple, arkaplanrenk2: .orange),
    Cardd(id: UUID(), coursetitle: "Algorithms", courseContent: "Explore common algorithms.", lastupdate: "2023-11-10", arkaplanren1: .pink, arkaplanrenk2: .cyan)
]


struct CarddView: View {
    var card: Cardd
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.coursetitle)
                .font(.headline)
                .foregroundColor(.white)
            Text(card.courseContent)
                .font(.body)
                .foregroundColor(.white)
            Spacer()
            HStack {
                Text(card.lastupdate)
                    .font(.caption)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "applelogo")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
        }
        .padding(30)
        .background(gradientBackground)
        .cornerRadius(30)
        .overlay(RoundedRectangle(cornerRadius: 30).strokeBorder(gradientOutline, lineWidth: 2))
        .shadow(color: Color(hex: "#5D11F7").opacity(0.3), radius: 7, x: 0, y: 0)
    }

    var gradientBackground: some View {
        LinearGradient(gradient: Gradient(colors: [Color(card.arkaplanren1), Color(card.arkaplanrenk2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var gradientOutline: LinearGradient {
        LinearGradient(gradient: Gradient(stops: [
            Gradient.Stop(color: Color.white.opacity(0.5), location: 0),
            Gradient.Stop(color: Color.clear, location: 0.5),
            Gradient.Stop(color: Color.white.opacity(0.5), location: 1)
        ]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}


