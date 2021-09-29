//
//  ContentView.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/23/21.
//

import SwiftUI

enum Tab: Hashable {
    case todoList
    case edit
    case reward
    case bridge
}

struct Theme {
    public static let gray = Color(.displayP3, red: 242/256, green: 242/256, blue: 247/256, opacity: 1)
}

class ItemListController: ObservableObject {
    @Published var itemList: [Item] = [Item(value: "Stub1"), Item(value: "Stub2")] {
        didSet {
            itemListDidChange()
        }
    }
    
    var itemListDidChange = {}
}

struct ContentView: View {
    
    @StateObject private var itemListController = ItemListController()
    @State private var isAlertPresented = false
    @State private var activeTab: Tab = .todoList
    @State private var featureToggleConfig = FeatureToggleConfig(isDeleteButtonActive: false, isEditModeActive: false) // Should be retrieved from server
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "TableViewbackgroundColor")
    }
    
    var body: some View {
        TabView(selection: $activeTab) {
            FirstTabContentView(
                itemListController: itemListController,
                isAlertPresented: $isAlertPresented,
                activeTab: $activeTab
            )
            .tabItem {
                Image(systemName: "star")
                Text("Todo List")
            }
            .tag(Tab.todoList)
            
            if featureToggleConfig.isEditModeActive {
                SecondTabContentView(itemListController: itemListController)
                    .tabItem {
                        Image(systemName: "pencil")
                        Text("Edit list")
                    }
                    .tag(Tab.edit)
            }
            
            ThirdTabContentView()
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Rewards")
                }
                .tag(Tab.reward)
            
            VStack {
                HeaderView(title: "UIKit -> SwiftUI bridge")
                    .frame(height: 70)
                FourthTabContentViewControllerWrapper(itemListController: itemListController)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Bridge")
            }
            .tag(Tab.bridge)
        }
        .environment(\.featureToggleConfig, $featureToggleConfig)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
            .preferredColorScheme(.dark)
        }
    }
}
#endif
