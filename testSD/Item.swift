//
//  Item.swift
//  testSD
//
//  Created by Nikolay Khort on 19.01.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
