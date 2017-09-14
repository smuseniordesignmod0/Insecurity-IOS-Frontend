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
    
    override init() {
        
    }

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
    
     func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "mock_report", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    report = ReportModel(JSON: object)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
