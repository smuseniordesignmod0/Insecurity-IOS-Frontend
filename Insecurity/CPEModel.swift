//
//  CPEModel.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/11/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation


import ObjectMapper

struct CPEModel: Mappable {
    var cpeString: String?
    var product: String?
    var update: String?
    var vendor: String?
    var version: String?
    var isApplication: Bool?
    var isHardware: Bool?
    var isOperatingSystem: Bool?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cpeString <- map["cpeString"]
        product <- map["getProduct"]
        update <- map["getUpdate"]
        vendor <- map["getVendor"]
        isApplication <- map["isApplication"]
        isHardware <- map["isHardware"]
        isOperatingSystem <- map["isOperatingSystem"]
    }
    
}
