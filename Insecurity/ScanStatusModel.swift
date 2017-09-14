//
//  ScanStatusModel.swift
//  Insecurity
//
//  Created by Logan Dorsey on 9/13/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import ObjectMapper

struct ScanStatusModel: Mappable {
    
    var progress: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        progress  <- map["progress"]
    }
    
}

