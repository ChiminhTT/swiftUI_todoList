//
//  Item.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/23/21.
//

import Foundation

struct Item: Identifiable {
    var id = UUID()
    var value: String
    
    #if DEBUG
    static var mockList: [Item] {
        return [
            Item(value: "item_1"),
            Item(value: "item_2")
        ]
    }
    #endif
}
