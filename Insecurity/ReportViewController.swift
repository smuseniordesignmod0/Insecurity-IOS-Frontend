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


class ReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var routerButton: MDCRaisedButton!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    //fake data
    let section = ["Devices"]
    let items = [["Device 1", "Device 2", "Device 3", "Device 4", "Device 5"], ["Port 1", "Port 2", "Port 3", "Port 4", "Port 5", "Port 6"]]
    
    var report: ReportModel?
    var deviceReport: DeviceReportModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareSaveButton()
        prepareRouterButton()
        prepareLabels()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        report?.timeStamp = result
        
        var reports = UserDefaults.standard.stringArray(forKey: "Reports")
        
        
        if reports == nil {
            reports = [String]()
        }
        
        let JSONString = report?.toJSONString(prettyPrint: true)
        reports?.append(JSONString!)
        
        UserDefaults.standard.set(reports, forKey: "Reports")
    }
    
    fileprivate func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
    }
    
    fileprivate func prepareSaveButton(){
        saveButton.tintColor = .inGreen
    }
    
    fileprivate func prepareRouterButton() {
        routerButton.setBackgroundColor(.inBlue, for: .normal)
        routerButton.setTitleColor(.white, for: .normal)
        routerButton.layer.cornerRadius = 5
    }
    
    fileprivate func prepareLabels() {
         let score = "Overall Score: " + String(describing: (report?.vulnerabilityScore)!)
         let grade = "Network Grade: " + (report?.vulnerabilityGrade)!
        
         scoreLabel.textColor = .lightGray
         scoreLabel.attributedText = addMultipleColorsTo(text: score, location: 0, length: 14)
       
        gradeLabel.textColor = .lightGray
        gradeLabel.attributedText = addMultipleColorsTo(text: grade, location: 0, length: 14)
        
    }
    
    // MARK: - Table view data source and delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return self.section[section]
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        if section == 0 {
            return (self.report?.devices?.count)!
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
            cell.textLabel?.text = self.report?.devices?[indexPath.row].ip
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
        
        if indexPath.section == 0 {
            deviceReport = report?.devices?[indexPath.row]
            performSegue(withIdentifier: "viewDevice", sender: cell)
            print("Device Selected")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .inBlue
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewDevice") {
            let vc = segue.destination as! DeviceReportViewController
            vc.deviceReport = self.deviceReport
        } else if (segue.identifier == "routerView") {
            let vc = segue.destination as! RouterViewController
            vc.routerReport = self.report?.router
        }
    }

  

}
