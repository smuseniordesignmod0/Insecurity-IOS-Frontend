//
//  ReportModel.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/11/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import ObjectMapper

struct ReportModel : Mappable {
    
    var id: String?
    var name: String?
    var deviceReport: DeviceReportModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["groupName"]
        
    }
}
