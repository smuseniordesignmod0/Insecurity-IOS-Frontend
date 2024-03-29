//
//  DeviceReportViewController.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 8/30/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents


class DeviceReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {
    
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var macLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var deviceReport:DeviceReportModel?
    var serviceReport: ServiceModel?
    
    let section = ["Services"]
    let items = [["Port 1", "Port 2", "Port 3"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareLabels()
        self.title = "Device Report"
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
        let ip = "IP: " + (deviceReport?.ip)!
        let mac = "Mac Address: " + (deviceReport?.macAddress)!
        let service = "Service: " + deviceReport!.services![0].serviceName!
        let accuracy = "Accuracy: " + String(describing: (deviceReport?.idAccuracy)!)
        
        ipLabel.textColor = .lightGray
        ipLabel.attributedText = addMultipleColorsTo(text: ip, location: 0, length: 3)
        
        macLabel.textColor = .lightGray
        macLabel.attributedText = addMultipleColorsTo(text: mac, location: 0, length: 12)
        
        servicesLabel.textColor = .lightGray
        servicesLabel.attributedText = addMultipleColorsTo(text: service, location: 0, length: 8)
        
        osLabel.textColor = .lightGray
        osLabel.attributedText = addMultipleColorsTo(text: accuracy, location: 0, length: 9)
 
    }
    
    
    // MARK: - Table view data source and delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return (self.deviceReport?.services?.count)!
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
        
        let port = "Port: " + String(describing: self.deviceReport!.services![indexPath.row].port!)
        
        cell.textLabel?.textColor = .lightGray
        cell.textLabel?.attributedText = addMultipleColorsTo(text: port, location: 0, length: 5)
                
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
            self.serviceReport = self.deviceReport?.services?[indexPath.row]
            performSegue(withIdentifier: "portView", sender: cell)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "portView") {
            let vc = segue.destination as! PortViewController
            vc.serviceReport = self.serviceReport
        }
    }

}
