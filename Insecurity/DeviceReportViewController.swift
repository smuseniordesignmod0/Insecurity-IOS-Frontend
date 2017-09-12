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
    
    let section = ["Open Ports"]
    let items = [["Port 1", "Port 2", "Port 3"]]
    
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
        ipLabel.text = "IP: " + (deviceReport?.ip)!
        macLabel.text = "Mac Address: " + (deviceReport?.macAddress)!
        servicesLabel.text = "Service: " + deviceReport!.services![0].serviceName!
        osLabel.text = "Accuracy: " + String(describing: deviceReport!.idAccuracy!)
 
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
        
        cell.textLabel?.text = "Port: " + String(describing: self.deviceReport!.services![indexPath.row].port!)
                
        return cell
    }
        
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .inBlue
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }

}
