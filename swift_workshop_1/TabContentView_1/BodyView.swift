//
//  BodyView.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/23/21.
//

import SwiftUI

struct BodyView: View {
    
    @ObservedObject var itemListController: ItemListController
    @Binding var isAlertViewPresented: Bool
    @Binding var activeTab: Tab
    @State private var isModalPresented: Bool = false
    @Environment(\.featureToggleConfig) var featureToggleConfig
    
    var body: some View {
        VStack() {
            if itemListController.itemList.isEmpty {
                VStack {
                    Spacer()
                    Text("No item")
                        .font(.title)
                    Spacer()
                }
            } else {
                List {
                    ForEach(itemListController.itemList) { item in
                        Text(item.value)
                            .font(.title)
                            .foregroundColor(Color.black)
                            .padding()
                    }
                    .onMove { indexSet, offset in
                            itemListController.itemList.move(fromOffsets: indexSet, toOffset: offset)
                    }
                    .onDelete { indexSet in
                        itemListController.itemList.remove(atOffsets: indexSet)
                    }
                    .listRowBackground(Theme.gray)
                }
                .listStyle(.insetGrouped)
                EditButton()
                    .padding()
                DeleteButton(isAlertViewPresented: $isAlertViewPresented, completion: {
                    itemListController.itemList.removeLast()
                    if itemListController.itemList.isEmpty {
                        activeTab = Tab.edit
                    }
                })
                .disabled(itemListController.itemList.isEmpty || !featureToggleConfig.isDeleteButtonActive.wrappedValue)
                Button("Modal Edit") {
                    isModalPresented = true
                }
                .padding()
                .disabled(!featureToggleConfig.isEditModeActive.wrappedValue)
                .sheet(isPresented: $isModalPresented) {
                    SecondTabContentView(itemListController: itemListController)
                }
                Button("Toggle feature toggles") {
                    featureToggleConfig.isDeleteButtonActive.wrappedValue.toggle()
                    featureToggleConfig.isEditModeActive.wrappedValue.toggle()
                }
                .padding()
            }
            Spacer(minLength: 40)
        }
    }
}

struct DeleteButton: View {
    @Binding var isAlertViewPresented: Bool
    var completion: (() -> Void)?
 
    var body: some View {
        if #available(iOS 15.0, *) {
            Button("Delete last item") {
                isAlertViewPresented = true
            }
            .alert(isPresented: $isAlertViewPresented) {
                Alert(
                    title: Text("Are you sure you want to delete this?"),
                    message: Text("There is no undo"),
                    primaryButton: .destructive(Text("Delete")) {
                        completion?()
                    },
                    secondaryButton: .cancel()
                )
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#if DEBUG
struct BodyView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            BodyView(
                itemListController: ItemListController(),
                isAlertViewPresented: .constant(false), activeTab: .constant(.todoList)
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        .previewDisplayName("iPhone 12 Pro Max")
            BodyView(
                itemListController: ItemListController(),
                isAlertViewPresented: .constant(false), activeTab: .constant(.todoList)
            )
                .preferredColorScheme(.dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
        }
    }
}
#endif
