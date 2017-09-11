//
//  ServiceModel.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/11/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import ObjectMapper

struct ServiceModel: Mappable {
    var serviceProtocol: String?
    var serviceName: String?
    var port: Int?
    var serviceCVE: [CVEModel]?
    var serviceCPE: [CPEModel]?
    var state: String?
    var reason: String?
    var banner: Int?
    var product: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        serviceProtocol <- map["Service/protocol"]
        serviceName <- map["Service/name"]
        port <- map["Service/port"]
        state <- map["Service/state"]
        reason <- map["Service/reason"]
        banner <- map["Service/banner"]
        product <- map["Service/product"]
        serviceCVE <- map["Service/service_CVE_list"]
        serviceCPE <- map["Service/service_CPE_list"]
        
    }
}
