//
//  DetailReportViewController.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/13/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import UIKit

class DetailReportViewController: UIViewController {
    @IBOutlet weak var summaryTextView: UITextView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var cveReport : CVEModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLabels()
    }
    
    func prepareLabels(){
        summaryTextView.text = cveReport?.summary
        summaryTextView.isUserInteractionEnabled = false
        scoreLabel.text = "Security Score: " + String(describing: cveReport?.CVSSSeverity!)
        //idLabel.text = "ID: " + (cveReport?.vulnID)!
    }
}
