//
//  SettingsTableViewController.swift
//  TipCalculator
//
//  Created by christopher ketant on 9/17/16.
//  Copyright © 2016 christopher ketant. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    var defaultTip: String!
    var themeIndex: NSInteger!
    
    @IBOutlet weak var colorSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tipPercents     = ["18%", "20%", "25%"]
        let defaults = UserDefaults.standard
        self.defaultTip = tipPercents[defaults.integer(forKey: "tip_index")]
        self.colorSegment.selectedSegmentIndex = defaults.integer(forKey: "color_theme_index")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = "Default Tip"
            cell.detailTextLabel?.text = self.defaultTip
            return cell
        }else {
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
            cell.textLabel?.text = "Default Tip"
            cell.detailTextLabel?.text = self.defaultTip
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "default_tip_segue", sender: self)
    }
    
    @IBAction func colorThemeChange(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(self.colorSegment.selectedSegmentIndex, forKey: "color_theme_index")
        defaults.synchronize()
    }
    
}
