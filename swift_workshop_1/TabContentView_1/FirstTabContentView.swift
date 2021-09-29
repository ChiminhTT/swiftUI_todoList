//
//  FirstTabContentView.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/23/21.
//

import SwiftUI

struct FirstTabContentView: View {
    @ObservedObject var itemListController: ItemListController
    @Binding var isAlertPresented: Bool
    @Binding var activeTab: Tab
    
    private let headerHeight: CGFloat = 70
    private let circleRadius: CGFloat = 70
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HeaderView(title: "Todo List")
                        .frame(height: headerHeight)
                    BodyView(
                        itemListController: itemListController,
                        isAlertViewPresented: $isAlertPresented,
                        activeTab: $activeTab
                    )
                }
                VStack(alignment: .leading) {
                    Spacer().frame(height: headerHeight-circleRadius/2)
                    HStack() {
                        Spacer().frame(width: circleRadius/2)
                        Image("avatar", bundle: Bundle(identifier: "swift_workshop_1"))
                            .resizable()
                            .frame(width: circleRadius, height: circleRadius)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .navigationTitle("SwiftUIWorkshop")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#if DEBUG
struct FirstTabContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        FirstTabContentView(
            itemListController: ItemListController(),
            isAlertPresented: .constant(false),
            activeTab: .constant(.todoList)
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        .previewDisplayName("iPhone 12 Pro Max")
    }
}
#endif
