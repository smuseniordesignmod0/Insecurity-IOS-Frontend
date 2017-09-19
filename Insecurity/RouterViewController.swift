//
//  RouterViewController.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/13/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
//
//  ReportViewController.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 8/30/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents


class RouterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var macLabel: UILabel!
    //fake data
    let section = ["Services", "CVE"]
    let items = [["Device 1", "Device 2", "Device 3", "Device 4", "Device 5"], ["Port 1", "Port 2", "Port 3", "Port 4", "Port 5", "Port 6"]]
    
    var routerReport: RouterModel?
    var cveReport: CVEModel?
    var serviceReport: ServiceModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareLabels()
        self.title = "Router Report"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    fileprivate func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
    }
    

    
    fileprivate func prepareLabels() {
        let score = "Security Score: " + String(describing: (routerReport?.vulnerabilityScore)!)
        let vendor = "Vendor: " + (routerReport?.vendor)!
        let mac = "MAC Address: " + (routerReport?.macAddress)!
        let ip = "IP Address: " + (routerReport?.ip)!
        
        scoreLabel.textColor = .lightGray
        scoreLabel.attributedText = addMultipleColorsTo(text: score, location: 0, length: 15)
        
        vendorLabel.textColor = .lightGray
        vendorLabel.attributedText = addMultipleColorsTo(text: vendor, location: 0, length: 7)
        
        macLabel.textColor = .lightGray
        macLabel.attributedText = addMultipleColorsTo(text: mac, location: 0, length: 12)
        
        ipLabel.textColor = .lightGray
        ipLabel.attributedText = addMultipleColorsTo(text: ip, location: 0, length: 11)
        
    }
    
    // MARK: - Table view data source and delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        if section == 0 {
            if self.routerReport?.hostCVE?.count != nil {
            return (self.routerReport?.services?.count)!
            } else {
                return 0
            }
        } else if section == 1 {
            return (self.routerReport?.hostCVE?.count)!
        }
        
        return 0
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
        
        if indexPath.section == 0 {
            let port = "Port: " + String(describing: (self.routerReport?.services?[indexPath.row].port)!)
            cell.textLabel?.attributedText = addMultipleColorsTo(text: port, location: 0, length: 5)
        } else if indexPath.section == 1 {
            let id = "ID: " +  (self.routerReport?.hostCVE?[indexPath.row].vulnID)!
            cell.textLabel?.attributedText = addMultipleColorsTo(text: id, location: 0, length: 3)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.separatorStyle = .none
        tableView.separatorStyle = .singleLine
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath as IndexPath)
        
        if indexPath.section == 1 {
            self.cveReport = self.routerReport?.hostCVE?[indexPath.row]
            performSegue(withIdentifier: "viewCVEReport", sender: cell)
        } else if indexPath.section == 0 {
            self.serviceReport = self.routerReport?.services?[indexPath.row]
            performSegue(withIdentifier: "viewPortReport", sender: cell)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .inBlue
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewCVEReport") {
            let vc = segue.destination as! DetailReportViewController
            vc.cveReport = self.cveReport
        } else if segue.identifier == "viewPortReport" {
            let vc = segue.destination as! PortViewController
            vc.serviceReport = self.serviceReport
        }
    }

    
    
}
