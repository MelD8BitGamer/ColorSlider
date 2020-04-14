//
//  SettingsSlidersVC.swift
//  ColorSlider
//
//  Created by Melinda Diaz on 4/14/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class SettingsSlidersVC: UIViewController {

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var brightnessStepper: UIStepper!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func colorSliderUsed(_ sender: UISlider) {
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
    }
    
}
