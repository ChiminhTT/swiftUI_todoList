//
//  ThirdTabContentViewContent.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/24/21.
//

import SwiftUI

struct Badge: Identifiable {
    let id = UUID()
    var color: Color = getRandomColor(currentColor: nil)
    
    static func getRandomColor(currentColor: Color?) -> Color {
        [Color.red, Color.green, Color.blue, Color.yellow, Color.purple]
            .filter { $0 != currentColor }
            .randomElement() ?? .black
    }
}

struct ThirdTabContentView: View {
    
    @State var badgeList: [Badge] = [ Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge() ]
    
    var body: some View {
        VStack {
            HeaderView(title: "Rewards")
                .frame(height: 70)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach($badgeList) { $badgeItem in
                        Image(systemName: "rosette")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(badgeItem.color)
                            .padding()
                            .background(Color("Gray"))
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    badgeItem.color = Badge.getRandomColor(currentColor: badgeItem.color)
                                }
                            }
                    }
                }
            }
            .padding()
            
            VStack {
                Button("Shuffle") {
                    withAnimation(.easeInOut) {
                        badgeList.shuffle()
                    }
                }
                Button("Add Badge") {
                    withAnimation(.easeIn) {
                        badgeList.append(Badge())
                    }
                }
                .padding()
                Button("Remove Badge") {
                    withAnimation(.easeIn) {
                        _ = badgeList.removeLast()
                    }
                }
                .disabled(badgeList.isEmpty)
                .padding()
            }
        }
    }
    
    private var columns: [GridItem] {
        return [
            GridItem(.adaptive(minimum: 60, maximum: .infinity), spacing: 10)
        ]
    }
}

#if DEBUG
struct ThirdTabContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ThirdTabContentView(
                badgeList: [Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge()]
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
            ThirdTabContentView(
                badgeList: [Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge(), Badge()]
            )
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
        }
    }
}
#endif
