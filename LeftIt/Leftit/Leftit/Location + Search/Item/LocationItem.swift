//
//  LocationItem.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 25/03/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class LocationItem {
    let id = UUID()
    //add a title for the location, like: work, gym etc, not just the place name
    @Attribute(.unique) var name: String
    var title: String
    var latitude: Double
    var longitude: Double
    //add an image that the user can choose from in order to differentiate the markers
    //i have to add the objects here
    
    //the location item is something that has his own object item so
    @Relationship(deleteRule: .cascade) var objects = [ObjectItem]()
    
    init(
        name: String = "",
        title: String = "",
        latitude: Double = 0.0,
        longitude: Double = 0.0
    ) {
        self.name = name
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
}
