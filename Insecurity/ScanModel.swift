//
//  ScanModel.swift
//  Insecurity
//
//  Created by Logan Dorsey on 9/13/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import ObjectMapper

struct ScanModel: Mappable {
    
    var id: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id  <- map["id"]
    }
    
}
