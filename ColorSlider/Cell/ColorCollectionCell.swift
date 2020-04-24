//
//  ColorCollectionCell.swift
//  ColorSlider
//
//  Created by Melinda Diaz on 4/14/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class ColorCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var hexColorLabel: UILabel!
    
    func setUpCell(eachCell: Crayon) {
        colorNameLabel.text = eachCell.name
        hexColorLabel.text = eachCell.hex
        colorNameLabel.textColor = .black
        if backgroundColor == .black {
            colorNameLabel.textColor = .white
            hexColorLabel.textColor = .white
        }
    }
}
