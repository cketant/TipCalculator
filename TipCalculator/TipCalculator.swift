//
//  ViewController.swift
//  TipCalculator
//
//  Created by christopher ketant on 9/16/16.
//  Copyright © 2016 christopher ketant. All rights reserved.
//

import UIKit

class TipCalculator: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        self.segment.selectedSegmentIndex = defaults.integer(forKey: "tip_index")
        billChange(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func billChange(_ sender: AnyObject) {
        let tipPercents     = [0.18, 0.2, 0.25]
        let bill            = Double(billField.text!) ?? 0
        let tip             = bill * tipPercents[segment.selectedSegmentIndex]
        let total           = bill + tip
        
        tipLabel.text       = String(format: "$%.2f", tip)
        totalLabel.text     = String(format: "$%.2f", total)
    }

    @IBAction func onTap(_ sender: AnyObject) {
        self.view!.endEditing(true)
    }

}

