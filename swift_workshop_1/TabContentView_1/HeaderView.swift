//
//  HeaderView.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/23/21.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(
                    colors: [.red, .blue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                VStack {
                    HStack {
                        Spacer()
                        Text(title)
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding()
                        Spacer()
                            .frame(width: 20)
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

#if DEBUG
struct HeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        HeaderView(title: "mock_title")
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
#endif
