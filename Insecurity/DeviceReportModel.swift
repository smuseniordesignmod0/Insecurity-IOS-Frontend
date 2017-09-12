//
//  DeviceReportModel.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/11/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import ObjectMapper

struct DeviceReportModel : Mappable {
    

    var vulnerabilityScore: Float?
    var ip: String?
    var macAddress: String?
    var vendor: String?
    var hostCPE: [CPEModel]?
    var hostCVE: [CVEModel]?
    var services: [ServiceModel]?
    var idAccuracy: Float?
    
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        vulnerabilityScore <- map["Device/Vulnerability_Score"]
        ip <- map["Device/IP"]
        macAddress <- map["Device/MAC_Address"]
        vendor <- map["Device/Vendor"]
        hostCPE <- map["Device/host_CPE_list"]
        services <- map["Device/Services"]
        idAccuracy <- map["Device/Identification_Accuracy"]

    }
}

