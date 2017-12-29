//
//  Enums.swift
//  Rynly
//
//  Created by N A Shashank on 12/19/17.
//  Copyright © 2017 N A Shashank. All rights reserved.
//

import Foundation
import CoreLocation

enum ServiceLocatorType {
    case mock
    case remote
}

enum EntryViewType {
    case login
    case register
}

enum Typealias {
    typealias defaultCallBack = () -> Void
    typealias boolCallBack = (Bool) -> Void
    typealias locationCallBack = (CLLocationCoordinate2D) -> Void
    typealias MapCallBack = (MapError?) -> Void
}

enum MapError:Error{
    case mapCreationFailure
    case dataSourceMissing
    case pathDrawFailed
    case pathFetchFailed
    
    func description() -> String
    {
        var strToReturn = String()
        switch self
        {
        case MapError.mapCreationFailure:
            strToReturn = "Failed to create a map"
        case MapError.dataSourceMissing:
            strToReturn = "Latitide and Longitude not specified"
        case MapError.pathDrawFailed:
            strToReturn = "Failed to draw route"
        case MapError.pathFetchFailed:
            strToReturn = "Failed to fetch route information"
        }
        return strToReturn
    }
}
