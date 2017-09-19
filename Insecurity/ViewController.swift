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
    var scanner: ScannerViewModel?
    var scanModel: ScanModel?
    var timer = Timer()
    var id: String?
    
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
        
        scanner = ScannerViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func getScanUpdate() {
        scanner?.getScanProgress(id: id!) { responseObject, error in
            // use responseObject and error here
            let temp = ScanStatusModel(JSON: responseObject!)
            if temp?.progress == 100 {
                self.report = self.scanner?.report
                self.progressBar.setProgress(value: 100, animationDuration: 1.0) {
                    print("Done animating!")
                    
                    self.timer.invalidate()
                    self.scanner?.getResults(id: self.id!) { responseObject, error in
                        self.report = ReportModel(JSON: responseObject!)
                        self.scoreView.isHidden = false
                        self.scoreLabel.text = "Your Network Security Score: " + (self.report?.vulnerabilityGrade)!
                        self.scanButton.isUserInteractionEnabled = true
                    }
                }
            } else {
                self.progressBar.setProgress(value: CGFloat((temp?.progress!)!), animationDuration: 1)
            }
        }
        
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
//        scanner?.startScan { responseObject, error in
//            // use responseObject and error here
//            self.scanModel = ScanModel(JSON: responseObject!)
//            self.id = self.scanModel?.id
//            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getScanUpdate), userInfo: nil, repeats: true)
//            
//        }
        
        self.scanButton.isUserInteractionEnabled = false
        self.scanButton.setTitle("Scanning", for: .normal)
        
        self.scanner?.readJson()
        self.report =  scanner?.report
        self.progressBar.setProgress(value: 100, animationDuration: 1.0) {
            self.scoreView.isHidden = false
            self.scoreLabel.text = "Your Network Security Score: " + (self.report?.vulnerabilityGrade)!
            self.scanButton.isUserInteractionEnabled = true
        }

    }
    
    
    @IBAction func newScanButtonPressed(_ sender: Any) {
        timer.invalidate()
        scoreView.isHidden = true
        scanButton.isUserInteractionEnabled = false
        scanButton.setTitle("Scan", for: .normal)
        progressBar.setProgress(value: 0, animationDuration: 1) {
            self.scanButton.isUserInteractionEnabled = true
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ReportViewController {
            vc.report = self.report
        }
    }
    
    

}

