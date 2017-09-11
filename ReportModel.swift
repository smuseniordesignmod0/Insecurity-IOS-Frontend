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
    
    var devices: [DeviceReportModel]?
    var router: RouterModel?
    var vulnerabilityScore: Float?
    var vulnerabilityGrade: String?
    var wirelessSecurityProtocols: [String]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        devices <- map["Report/Devices"]
        router <- map["Report/Router"]
        vulnerabilityScore <- map["Report/Vulnerability_Score"]
        vulnerabilityGrade <- map["Report/Vulnerability_Grade"]
        wirelessSecurityProtocols <- map["Report/Wireless_Security_Protocols"]
        
    }
}
