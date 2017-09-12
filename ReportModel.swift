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
    var timeStamp: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        devices <- map["Devices"]
        router <- map["Router"]
        vulnerabilityScore <- map["Vulnerability_Score"]
        vulnerabilityGrade <- map["Vulnerability_Grade"]
        wirelessSecurityProtocols <- map["Wireless_Security_Protocols"]
        timeStamp <- map["timeStamp"]
        
    }
}
