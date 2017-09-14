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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareLabels()
    }
    
    fileprivate func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func prepareLabels() {
        //serviceNameLabel.text = "Service Name: " + (serviceReport?.serviceName)!
        portLabel.text = "Port: " +  String(describing: serviceReport?.port)
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
        
        cell.textLabel?.text = "CVE Score: " + String(describing: self.serviceReport!.serviceCVE![indexPath.row].vulnID!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .inBlue
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
}
