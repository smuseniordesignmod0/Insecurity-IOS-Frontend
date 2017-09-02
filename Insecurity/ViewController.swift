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

class ViewController: UIViewController {

    @IBOutlet weak var historyButton: UIBarButtonItem!

    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scanButton: MDCRaisedButton!
    @IBOutlet weak var instructionsLabel: UILabel!
 
    @IBOutlet weak var progressBar: UICircularProgressRingView!
    
    @IBOutlet weak var newScanButton: MDCRaisedButton!


    @IBOutlet weak var viewReportButton: MDCRaisedButton!
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
        progressBar.setProgress(value: 100, animationDuration: 5.0) {
            print("Done animating!")
            self.scoreView.isHidden = false
            self.scoreLabel.text = "Your Network Security Score: A"
            // Do anything your heart desires...
        }
    }
    
    
    @IBAction func newScanButtonPressed(_ sender: Any) {
        scoreView.isHidden = true
        scanButton.isUserInteractionEnabled = false
        progressBar.setProgress(value: 0, animationDuration: 1) {
            self.scanButton.isUserInteractionEnabled = true
        }
        
    }

}

