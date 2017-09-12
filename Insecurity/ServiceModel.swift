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
        serviceProtocol <- map["protocol"]
        serviceName <- map["name"]
        port <- map["port"]
        state <- map["state"]
        reason <- map["reason"]
        banner <- map["banner"]
        product <- map["product"]
        serviceCVE <- map["service_CVE_list"]
        serviceCPE <- map["service_CPE_list"]
        
    }
}
