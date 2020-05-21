//
//  ColorCollectionCell.swift
//  ColorSlider
//
//  Created by Melinda Diaz on 4/14/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class ColorCollectionCell: UICollectionViewCell {
    //TODO: Fix black color if else statement, why is the name not showing in the label
    
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var hexColorLabel: UILabel!
    
    func setUpCell(eachCell: Crayon) {
        colorNameLabel.text = eachCell.name.description
        hexColorLabel.text = eachCell.hex.description
        colorNameLabel.textColor = .black
    backgroundColor = UIColor(red: CGFloat(eachCell.red/255), green: CGFloat(eachCell.green/255), blue: CGFloat(eachCell.blue/255), alpha: 1)
        if eachCell.name == "Black" {
            colorNameLabel.textColor = .white
            hexColorLabel.textColor = .white
        }
//        else {
//
//        }
    }
}
