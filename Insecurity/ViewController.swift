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

    @IBOutlet weak var scanButton: MDCRaisedButton!
    @IBOutlet weak var instructionsLabel: UILabel!
 
    @IBOutlet weak var scanningView: UIView!
    @IBOutlet weak var progressBar: UICircularProgressRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareScanButton()
        prepareInstructionsLabel()
        prepareProgressBar()
        scanningView.isHidden = true

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
    
    fileprivate func prepareInstructionsLabel() {
        instructionsLabel.textColor = .lightGray
    }
    
    fileprivate func prepareProgressBar () {
        progressBar.innerRingColor = .inGreen
    }

    @IBAction func scanButtonPressed(_ sender: Any) {
        scanningView.isHidden = false
    }

}

