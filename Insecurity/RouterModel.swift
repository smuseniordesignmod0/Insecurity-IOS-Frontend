//
//  RouterModel.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/11/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import ObjectMapper

struct RouterModel: Mappable {

    var vulnerabilityScore: Float?
    var ip: String?
    var macAddress: String?
    var vendor: String?
    var hostCPE: [CPEModel]?
    var hostCVE: [CVEModel]?
    var services: [ServiceModel]?
    var idAccuracy: Float?
    var publicID: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        vulnerabilityScore <- map["Vulnerability_Score"]
        ip <- map["IP"]
        macAddress <- map["MAC_Address"]
        vendor <- map["Vendor"]
        hostCPE <- map["host_CPE_list"]
        services <- map["Services"]
        idAccuracy <- map["Identification_Accuracy"]
        publicID <- map["publicIP"]
    }
}

