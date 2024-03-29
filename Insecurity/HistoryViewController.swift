//
//  HistoryViewController.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/3/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import ObjectMapper

class HistoryViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let section = ["History"]
    let items = [["Report on 05/10/2014", "Report on 06/11/2015", "Report on 11/10/2016", "Report on 07/12/2017"]]
    var reports: [ReportModel]?
    var report: ReportModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        loadHistory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    fileprivate func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
    }
    
    fileprivate func loadHistory(){
        reports = [ReportModel]()
        let tempReports = UserDefaults.standard.stringArray(forKey: "Reports")
        
        if tempReports != nil {
            
            for report in tempReports! {
                let r = ReportModel(JSONString: report)
                reports?.append(r!)                
            }
        }
        
        tableView.reloadData()
        
    }
        
    // MARK: - Table view data source and delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.reports!.count
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
            cell.textLabel?.text = "Report on " + (reports?[indexPath.row].timeStamp)!
            self.report = reports?[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .inBlue
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toReport") {
            
            let vc = segue.destination as! ReportViewController
            vc.report = self.report
        }
    }
}
