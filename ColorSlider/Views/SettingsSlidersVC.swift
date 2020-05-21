//
//  SettingsSlidersVC.swift
//  ColorSlider
//
//  Created by Melinda Diaz on 4/14/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit
//TODO: Fix Slider values
//TODO: Fix reset
//TODO: Add a save button
//TODO: Add Read me GIF
//TODO: USE CUSTOM Delegate to change the background of the table view once i switch back to the collection view

struct AppKey { //we use a constant so we dont just you app color everywhere
    //when you persist it to the phone. So it saves it as app color
    static let appColorKey = "background color"
    static let red = "red"
    static let blue = "blue"
    static let green = "green"
}

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
    
    var theCrayonColors:Crayon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      updateBackgroundColor()
       setSliderValue()
    }
    
    @IBAction func colorSliderUsed(_ sender: UISlider) {
        view.backgroundColor = UIColor(red: CGFloat(redSlider!.value), green: CGFloat(greenSlider!.value), blue: CGFloat(blueSlider!.value), alpha: CGFloat(sender.value))
        redLabel.text = redSlider.value.description
        greenLabel.text = greenSlider.value.description
        blueLabel.text = blueSlider.value.description
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        view.backgroundColor = UIColor(red: CGFloat(redSlider!.value), green: CGFloat(greenSlider!.value), blue: CGFloat(blueSlider!.value), alpha: CGFloat(sender.value))
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        //updateBackgroundColor()
        setSliderValue()
    }
    
    
    func updateBackgroundColor() {
        view.backgroundColor = UIColor(red: CGFloat(theCrayonColors.red/255), green: CGFloat(theCrayonColors.green/255), blue: CGFloat(theCrayonColors.blue/255), alpha: 1)
    }
    
    func setSliderValue() {
        redSlider.value = Float(theCrayonColors.red/255)
        blueSlider.value = Float(theCrayonColors.blue/255)
        greenSlider.value = Float(theCrayonColors.green/255)
    }
}
