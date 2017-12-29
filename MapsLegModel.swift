//
//  MapsLegModel.swift
//  Rynly
//
//  Created by N A Shashank on 12/30/17.
//  Copyright © 2017 N A Shashank. All rights reserved.
//

import UIKit
import GoogleMaps

struct LegModel {
    var path = GMSPath()
    var distance = [String:Any]()
    var duration = [String:Any]()
    var endAddress = String()
    var startAddress = String()
    var startLocation = [String:Any]()
    var endLocation = [String:Any]()
}
