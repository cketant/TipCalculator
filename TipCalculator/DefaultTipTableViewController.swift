//
//  DefaultTipTableViewController.swift
//  TipCalculator
//
//  Created by christopher ketant on 9/17/16.
//  Copyright © 2016 christopher ketant. All rights reserved.
//

import UIKit

class DefaultTipTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tipPercents     = ["18%", "20%", "25%"]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell" ) {
            let defaults = UserDefaults.standard
            let tipIndex = defaults.integer(forKey: "tip_index")
            if indexPath.row == tipIndex {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }else {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            return cell
        }else {
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            let defaults = UserDefaults.standard
            let tipIndex = defaults.integer(forKey: "tip_index")
            if indexPath.row == tipIndex {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }else {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            cell.textLabel?.text = tipPercents[indexPath.row]
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let defaults = UserDefaults.standard
        defaults.set(indexPath.row, forKey: "tip_index")
        defaults.synchronize()
        self.tableView.reloadData()
    }

}
