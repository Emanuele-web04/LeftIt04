//
//  ObjectItem.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 26/03/24.
//

import Foundation
import SwiftData

@Model
class ObjectItem {
    var id = UUID().uuidString
    @Attribute(.unique) var name: String
    var isBrought: Bool
    //altrimenti qua creo una variabile che è di tipo stringa, quando creo la task gli assegno il location.name la a questa variabile, e nella sua mostro solo quamdo le task hanno la stessa variabile del nome della view in cui sono in, potrei
    var location: LocationItem?
    
    init(
        name: String = "",
        isBrought: Bool = false
    ) {
        self.name = name
        self.isBrought = isBrought
    }
}
