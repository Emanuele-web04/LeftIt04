//
//  ObjectItem.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 26/03/24.
//

import Foundation
import SwiftData

@Model
final class ObjectItem {
    let id = UUID()
    @Attribute(.unique) var name: String
    var isBrought: Bool
    
    init(name: String = "", isBrought: Bool = false) {
        self.name = name
        self.isBrought = isBrought
    }
}
