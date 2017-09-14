//
//  ScannerViewModel.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/13/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import Alamofire

//Right now we're using the mock endpoint
class ScannerViewModel : NSObject {
    
    var scan: ScanModel?
    var report: ReportModel?

func startScan() -> Int
{
    let parameters : Parameters = ["scanType": "Complete"]
    
    Alamofire.request("http://private-anon-a5ee7e6284-insecurityapi.apiary-mock.com/Scanner/Scan", parameters: parameters, encoding: URLEncoding.httpBody).responseJSON
        { response in
            if let json = response.result.value as? [String : Any]
            {
                self.scan = ScanModel(JSON: json)
            }
        }
    return scan!.id!
    
}

func getScanProgress() -> Int
{
    var status: ScanStatusModel?
    let parameters : Parameters = ["id": scan?.id ?? 0]
    
    Alamofire.request("https://private-anon-a5ee7e6284-insecurityapi.apiary-mock.com/Scan//Status", parameters: parameters).responseJSON
        { response in
            if let json = response.result.value as? [String : Any]
            {
                status = ScanStatusModel(JSON: json)
            }
        }
    
    return (status?.progress)!

}

func getResults()
{
    let parameters : Parameters = ["id": scan?.id ?? 0]

    Alamofire.request("https://private-anon-a5ee7e6284-insecurityapi.apiary-mock.com/Scan//Report", parameters: parameters).responseJSON
    { response in
        if let json = response.result.value as? [String : Any]
        {
            self.report = ReportModel(JSON: json)
        }
    }
    
}

}
