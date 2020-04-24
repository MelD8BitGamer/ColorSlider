//
//  ViewController.swift
//  ColorSlider
//
//  Created by Melinda Diaz on 4/14/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class ColorList: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var colorCollection: UICollectionView!
    
    let crayonColors = Crayon.allTheCrayons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollection.dataSource = self
        colorCollection.delegate = self
        searchBar.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorDetailSetting = segue.destination as? SettingsSlidersVC,
            let indexPath = colorCollection.indexPathsForSelectedItems else {
                fatalError("Did not segue to SettingsSliderVC") }
        //        colorDetailSetting.theCrayonColors = crayonColors[indexPath]
        //        colorDetailSetting.navigationItem.title =
    }
}

extension ColorList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crayonColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "thisColorCell", for: indexPath)
        let crayons = crayonColors[indexPath.row]
        cell.backgroundColor = UIColor(red: CGFloat(crayons.red/255), green: CGFloat(crayons.green/255), blue: CGFloat(crayons.blue/255), alpha: 1)
        return cell
    }
    
    
}
extension ColorList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let maxWidth = UIScreen.main.bounds.size.width //device width
        let numberOfItems: CGFloat = 3 //items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
    
    extension ColorList: UISearchBarDelegate {
        
}
