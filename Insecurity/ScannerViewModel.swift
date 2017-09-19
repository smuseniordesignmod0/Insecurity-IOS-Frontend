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
    
    func startScan(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        makeCall(completionHandler: completionHandler)
    }
    
    func makeCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let parameters : Parameters = ["scanType": "Complete"]
        
        Alamofire.request("http://192.168.1.4/Scanner/Scan", method: .post, parameters: parameters, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }

        }
    }



    func getScanProgress(id: String, completionHandler: @escaping ([String : Any]?, Error?) -> () ) {
        makeProgressCall(id: id, completionHandler: completionHandler)

    }
    
    func makeProgressCall(id:String, completionHandler: @escaping ([String : Any]?, Error?) -> ()) {

        let parameters : Parameters = ["id": id]
        let url = "http://192.168.1.4/Scan/" + id + "/Status"
        
        Alamofire.request(url, parameters: parameters).responseJSON (completionHandler:
            { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value as? [String : Any], nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        })
    }
    
    func getResults(id: String, completionHandler: @escaping ([String : Any]?, Error?) -> ()){
        makeResultsCall(id: id, completionHandler: completionHandler)
    }
    
    func makeResultsCall(id: String, completionHandler: @escaping ([String : Any]?, Error?) -> ()){
        let parameters : Parameters = ["id": id]
         let url = "http://192.168.1.4/Scan/" + id + "/Report"
        
        Alamofire.request(url, parameters: parameters).responseJSON
            { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value as? [String : Any], nil)
                case .failure(let error):
                    completionHandler(nil, error)
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
