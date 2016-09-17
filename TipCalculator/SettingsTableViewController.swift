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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tipPercents     = ["18%", "20%", "25%"]
        let defaults = UserDefaults.standard
        self.defaultTip = tipPercents[defaults.integer(forKey: "tip_index")]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = "Default Tip"
            cell.detailTextLabel?.text = self.defaultTip
            return cell
        }else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Default Tip"
            cell.detailTextLabel?.text = self.defaultTip
            return cell
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
