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
    @IBOutlet weak var fieldView: UIView!
    var fieldOriginalY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(TipCalculator.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TipCalculator.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
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
        self.billField.placeholder = NSLocale.current.currencySymbol
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateNavBar()
        self.billField.becomeFirstResponder()
    }

    func keyboardWillShow(){
        let x = self.fieldView.frame.origin.x
        self.fieldOriginalY = self.fieldView.frame.origin.y
        let width = self.fieldView.frame.size.width
        let height = self.fieldView.frame.size.height
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        UIView.animate(withDuration: 0.2) { 
            self.fieldView.frame = CGRect.init(x: x, y: navBarHeight!, width: width, height: height)
            self.showViewElements(isHidden: false)
        }
    }
    
    func keyboardWillHide(){
        let x = self.fieldView.frame.origin.x
        let width = self.fieldView.frame.size.width
        let height = self.fieldView.frame.size.height
        UIView.animate(withDuration: 0.2) {
            self.fieldView.frame = CGRect.init(x: x, y: self.fieldOriginalY, width: width, height: height)
            self.showViewElements(isHidden: true)
        }
    }
    
    @IBAction func billChange(_ sender: AnyObject) {
        let tipPercents     = [0.18, 0.2, 0.25]
        let bill            = Double(billField.text!) ?? 0
        let tipNum          = bill * tipPercents[segment.selectedSegmentIndex]
        let tip             = NumberFormatter.localizedString(from: NSNumber.init(value: bill * tipPercents[segment.selectedSegmentIndex]),
                                                              number: NumberFormatter.Style.currency)
        let total           = NumberFormatter.localizedString(from: NSNumber.init(value: tipNum+bill), number: NumberFormatter.Style.currency)

        
        tipLabel.text       = tip
        totalLabel.text     = total
        self.billField.placeholder = NSLocale.current.currencySymbol
        
        let defaults        = UserDefaults.standard
        defaults.set(segment.selectedSegmentIndex, forKey: "tip_index")
        defaults.synchronize()
        
        self.animateNavBar()
        
    }

    @IBAction func onTap(_ sender: AnyObject) {
        self.view!.endEditing(true)
    }
    
    func showViewElements(isHidden: Bool) {
        if isHidden {
            self.segment.isHidden = true
            self.tipLabel.isHidden = true
            self.tipTitleLabel.isHidden = true
            self.totalLabel.isHidden = true
            self.totalTitleLabel.isHidden = true
        }else {
            self.segment.isHidden = false
            self.tipLabel.isHidden = false
            self.tipTitleLabel.isHidden = false
            self.totalLabel.isHidden = false
            self.totalTitleLabel.isHidden = false
        }
    }
    
    func animateNavBar() {
        let defaults = UserDefaults.standard
        var color: UIColor = UIColor.white
        switch defaults.integer(forKey: "tip_index") {
        case 0:
            color = UIColor.green
        case 1:
            color = UIColor.yellow
        case 2:
            color = UIColor.red
        default:
            color = UIColor.green
        }
        UIView.animate(withDuration: 0.9) {
            self.navigationController?.navigationBar.barTintColor = color
        }

    }
    
    func animateBackground(isLight: Bool){
        if isLight {
            self.view.backgroundColor = UIColor.white
            self.fieldView.backgroundColor = UIColor.white
            self.tipTitleLabel.textColor = UIColor.black
            self.totalTitleLabel.textColor = UIColor.black
            self.tipLabel.textColor = UIColor.black
            self.totalLabel.textColor = UIColor.black
            self.billField.backgroundColor = UIColor.white
            self.billField.textColor = UIColor.black
            self.segment.tintColor = UIColor.black
        }else {
            self.view.backgroundColor = UIColor.black
            self.fieldView.backgroundColor = UIColor.black
            self.tipTitleLabel.textColor = UIColor.white
            self.totalTitleLabel.textColor = UIColor.white
            self.tipLabel.textColor = UIColor.white
            self.totalLabel.textColor = UIColor.white
            self.billField.backgroundColor = UIColor.black
            self.billField.textColor = UIColor.white
            self.segment.tintColor = UIColor.white
        }
    
    }

}

