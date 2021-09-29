//
//  SecondTabViewContent.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/23/21.
//

import SwiftUI

enum SecondtabMode {
    case edit
    case add
}

struct SecondTabContentView: View {
    
    @State private var newItemValue: String = ""
    @ObservedObject var itemListController: ItemListController
    @Environment(\.presentationMode) var presentationMode
    var mode: SecondtabMode = .add
    var item: Item?
    
    var body: some View {
        VStack {
            HeaderView(title: getTitle())
                .frame(height: 70)
            HStack {
                Spacer(minLength: 40)
                TextField("New Item", text: $newItemValue)
                    .styleAsTextfield()
                Spacer(minLength: 40)
            }
            Spacer()
            Button(getButtonTitle()) {
                buttonAction()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(newItemValue.isEmpty)
            .padding()
        }
    }
    
    func getTitle() -> String {
        switch mode {
        case .add: return "Add item"
        case .edit: return "Edit item"
        }
    }
    
    func getButtonTitle() -> String {
        switch mode {
        case .add: return "Save"
        case .edit: return "Edit"
        }
    }
    
    func buttonAction() {
        switch mode {
        case .add:
            itemListController.itemList.append(Item(value: newItemValue))
        case .edit:
            let newItem = Item(value: newItemValue)
            guard let index = itemListController.itemList.firstIndex(where: {
                $0.id == item?.id
            }) else { return }
            itemListController.itemList[index] = newItem
        }
    }
}

#if DEBUG
struct SecondTabContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        SecondTabContentView(
            itemListController: ItemListController()
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        .previewDisplayName("iPhone 12 Pro Max")
    }
}
#endif
