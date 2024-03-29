//
//  PortViewController.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/13/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//
//

import Foundation
import UIKit

class PortViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var portLabel: UILabel!
    
    let section = ["CVE"]
    var serviceReport: ServiceModel?
    var cveReport: CVEModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareLabels()
        self.title = "Port Report"
    }
    
    fileprivate func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func prepareLabels() {
        
        let serviceName = "Service Name: " + (serviceReport?.serviceName)!
        let port = "Port: " +  String(describing: (serviceReport?.port)!)
        
        serviceNameLabel.textColor = .lightGray
        serviceNameLabel.attributedText = addMultipleColorsTo(text: serviceName, location: 0, length: 13)
        
        portLabel.textColor = .lightGray
        portLabel.attributedText = addMultipleColorsTo(text: port, location: 0, length: 5)
    }
    
    
    // MARK: - Table view data source and delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        if(self.serviceReport?.serviceCVE?.count == nil){
            return 0
        } else {
            return (self.serviceReport?.serviceCVE?.count)!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath as IndexPath)
        cell.selectionStyle = .none
        
        cell.textLabel?.textColor = .lightGray
        
        let id = "ID: " + String(describing: self.serviceReport!.serviceCVE![indexPath.row].vulnID!)
        cell.textLabel?.attributedText = addMultipleColorsTo(text: id, location: 0, length: 3)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .inBlue
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.separatorStyle = .none
        tableView.separatorStyle = .singleLine
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath as IndexPath)
        
        if indexPath.section == 0 {
            self.cveReport = self.serviceReport?.serviceCVE?[indexPath.row]
            performSegue(withIdentifier: "viewDetailReport", sender: cell)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewDetailReport") {
            let vc = segue.destination as! DetailReportViewController
            vc.cveReport = self.cveReport
        }
    }
}
