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
    let section = ["CVE", "Services"]
    let items = [["Device 1", "Device 2", "Device 3", "Device 4", "Device 5"], ["Port 1", "Port 2", "Port 3", "Port 4", "Port 5", "Port 6"]]
    
    var routerReport: RouterModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareLabels()
        
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
        scoreLabel.text = "Security Score: " + String(describing: (routerReport?.vulnerabilityScore)!)
        
    }
    
    // MARK: - Table view data source and delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        if section == 0 {
            if self.routerReport?.hostCVE?.count != nil {
            return (self.routerReport?.hostCVE?.count)!
            } else {
                return 0
            }
        } else if section == 1 {
            return (self.routerReport?.services?.count)!
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
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "ID: " +  (self.routerReport?.hostCVE?[indexPath.row].vulnID)!
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "Port: " + String(describing: self.routerReport?.services?[indexPath.row].port)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.separatorStyle = .none
        tableView.separatorStyle = .singleLine
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath as IndexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        
//        if indexPath.section == 0 {
//            
//            performSegue(withIdentifier: "viewDevice", sender: cell)
//            print("Device Selected")
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .inBlue
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "viewDevice") {
//            
//            let vc = segue.destination as! DeviceReportViewController
//            vc.deviceReport = self.deviceReport
//        }
//    }
//    
    
    
}
