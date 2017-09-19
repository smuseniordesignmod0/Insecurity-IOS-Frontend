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
        let score = "Security Score: " + String(describing: (cveReport?.CVSSSeverity)!)
        let id = "ID: " + (cveReport?.vulnID)!
        
        summaryTextView.textColor = .lightGray
        summaryTextView.font = UIFont(name: "Helvetica", size: 17)
        summaryTextView.text = cveReport?.summary
        summaryTextView.isUserInteractionEnabled = false
        
        scoreLabel.textColor = .lightGray
        scoreLabel.attributedText = addMultipleColorsTo(text: score, location: 0, length: 15)
        
        
        idLabel.textColor = .lightGray
        idLabel.attributedText = addMultipleColorsTo(text: id, location: 0, length: 3)
    }
}
