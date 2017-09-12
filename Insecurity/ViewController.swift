//
//  ViewController.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 8/29/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import UIKit
import MaterialComponents
import UICircularProgressRing
import Alamofire
import ObjectMapper
class ViewController: UIViewController {

    @IBOutlet weak var historyButton: UIBarButtonItem!

    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scanButton: MDCRaisedButton!
    @IBOutlet weak var instructionsLabel: UILabel!
 
    @IBOutlet weak var progressBar: UICircularProgressRingView!
    
    @IBOutlet weak var newScanButton: MDCRaisedButton!


    @IBOutlet weak var viewReportButton: MDCRaisedButton!
    
    var report : ReportModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareScanButton()
        prepareLabels()
        prepareProgressBar()
        prepareNewScanButton()
        prepareViewReportButton()
        scoreView.isHidden = true
        historyButton.tintColor = .inBlue

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func prepareScanButton() {
        scanButton.setBackgroundColor(.inGreen, for: .normal)
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.layer.cornerRadius = 5
    }
    
    fileprivate func prepareLabels() {
        instructionsLabel.textColor = .lightGray
        scoreLabel.textColor = .lightGray
    }
    
    fileprivate func prepareProgressBar () {
        progressBar.innerRingColor = .inGreen
    }
    
    fileprivate func prepareNewScanButton() {
        newScanButton.setBackgroundColor(.inRed, for: .normal)
        newScanButton.setTitleColor(.white, for: .normal)
        newScanButton.layer.cornerRadius = 5
    }
    
    fileprivate func prepareViewReportButton() {
        viewReportButton.setBackgroundColor(.inBlue, for: .normal)
        viewReportButton.setTitleColor(.white, for: .normal)
        viewReportButton.layer.cornerRadius = 5
    }

    @IBAction func scanButtonPressed(_ sender: Any) {
        readJson()
        scanButton.isUserInteractionEnabled = false
        scanButton.setTitle("Scanning", for: .normal)
        progressBar.setProgress(value: 100, animationDuration: 4.0) {
            print("Done animating!")
            self.scoreView.isHidden = false
            self.scoreLabel.text = "Your Network Security Score: " + (self.report?.vulnerabilityGrade)!
            self.scanButton.isUserInteractionEnabled = true
        }
    }
    
    
    @IBAction func newScanButtonPressed(_ sender: Any) {
        scoreView.isHidden = true
        scanButton.isUserInteractionEnabled = false
         scanButton.setTitle("Scan", for: .normal)
        progressBar.setProgress(value: 0, animationDuration: 1) {
            self.scanButton.isUserInteractionEnabled = true
        }
        
    }
    
    fileprivate func scan(){
        Alamofire.request("http://api.insecurity/Scan/id/Report").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("Working")
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
//   fileprivate func loadJson(forFilename fileName: String){
//        
//        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//            if let data = NSData(contentsOf: url) {
//                do {
//                   // let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
//                    
//                    report?.mapping(map: data as! Map)
//                    
//    
//                } catch {
//                    print("Error!! Unable to parse  \(fileName).json")
//                }
//            }
//            print("Error!! Unable to load  \(fileName).json")
//        }
//    
//    }
    
    fileprivate func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "mock_report", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    report = ReportModel(JSON: object)
                    print(report)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ReportViewController {
            vc.report = self.report
        }
    }
    
    

}

