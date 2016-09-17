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
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var billTitleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        self.segment.selectedSegmentIndex = defaults.integer(forKey: "tip_index")
        billChange(self)
        switch defaults.integer(forKey: "color_theme_index") {
        case 0:
            self.animateBackground(isLight: true)
        case 1:
            self.animateBackground(isLight: false)
        default:
            self.animateBackground(isLight: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateNavBar()
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
        
        self.animateNavBar()
        
    }

    @IBAction func onTap(_ sender: AnyObject) {
        self.view!.endEditing(true)
    }
    
    func animateNavBar() {
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
            self.navigationController?.navigationBar.backgroundColor = color;
        }

    }
    
    func animateBackground(isLight: Bool){
        if isLight {
            self.view.backgroundColor = UIColor.white
            self.billTitleLabel.textColor = UIColor.black
            self.tipTitleLabel.textColor = UIColor.black
            self.totalTitleLabel.textColor = UIColor.black
//            self.billField.textColor = UIColor.black
            self.tipLabel.textColor = UIColor.black
            self.totalLabel.textColor = UIColor.black
        }else {
            self.view.backgroundColor = UIColor.black
            self.billTitleLabel.textColor = UIColor.white
            self.tipTitleLabel.textColor = UIColor.white
            self.totalTitleLabel.textColor = UIColor.white
//            self.billField.textColor = UIColor.white
            self.tipLabel.textColor = UIColor.white
            self.totalLabel.textColor = UIColor.white
        }
    
    }

}

