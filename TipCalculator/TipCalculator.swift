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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateBackground()
    }

    @IBAction func billChange(_ sender: AnyObject) {
        let tipPercents     = [0.18, 0.2, 0.25]
        let bill            = Double(billField.text!) ?? 0
        let tip             = bill * tipPercents[segment.selectedSegmentIndex]
        let total           = bill + tip
        
        tipLabel.text       = String(format: "$%.2f", tip)
        totalLabel.text     = String(format: "$%.2f", total)
        
        let defaults        = UserDefaults.standard
        defaults.set(segment.selectedSegmentIndex, forKey: "tip_index")
        defaults.synchronize()
        
        self.animateBackground()
        
    }

    @IBAction func onTap(_ sender: AnyObject) {
        self.view!.endEditing(true)
    }
    
    func animateBackground() {
        let defaults = UserDefaults.standard
        var color: UIColor = UIColor.white
        switch defaults.integer(forKey: "tip_index") {
        case 0:
            color = UIColor.white
        case 1:
            color = UIColor.lightGray
        case 2:
            color = UIColor.darkGray
        default:
            color = UIColor.white
        }
        UIView.animate(withDuration: 0.4) {
            self.view.backgroundColor = color
        }

    }

}

