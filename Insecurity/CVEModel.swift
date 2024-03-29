//
//  CVEModel.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/11/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import ObjectMapper

struct CVEModel: Mappable {
    var vulnID: String?
    var summary: String?
    var CVSSSeverity: Float?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        vulnID <- map["Vuln_ID"]
        summary <- map["Summary"]
        CVSSSeverity <- map["CVSS_Severity"]
    }
    
}
