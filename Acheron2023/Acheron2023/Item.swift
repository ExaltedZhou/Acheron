//
//  Item.swift
//  Acheron2023
//
//  Created by Albert Zhou on 10/8/23.
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
