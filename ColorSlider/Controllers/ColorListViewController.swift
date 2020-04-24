//
//  ViewController.swift
//  ColorSlider
//
//  Created by Melinda Diaz on 4/14/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class ColorListViewController: UIViewController {
    //TODO: Rid notes
    //TODO: FIX COLLECTION CELL TEXT
    //TODO: FIx slider show background
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var colorCollection: UICollectionView!
    
    var crayonColors = Crayon.allTheCrayons {
        didSet {
            colorCollection.reloadData()
        }
    }
    var userQuery = "" {
        //when the property observer that is attached to changes then DidSet gets triggered
        didSet { //trailing closure syntax
            if userQuery.isEmpty { //if the user types and cancels it then the search bar is empty which THEN the tableview repopulates
                crayonColors = Crayon.allTheCrayons //this repopulates the data
            } else {
                crayonColors = Crayon.allTheCrayons.filter{$0.name.lowercased().contains(userQuery.lowercased())} //this filters the data based on the user query
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isTranslucent = true
        colorCollection.dataSource = self
        colorCollection.delegate = self
        searchBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) { //will be
        super.viewWillAppear(true)
        updateAppColor()
    }
    
    private func updateAppColor() { //when you store something to userdefaults it will be ANY unless you TYPECAST it
        if let colorName = UserDefaults.standard.object(forKey: AppKey.appColorKey) as? String {
            view.backgroundColor = UIColor(named: colorName)//this saves the color and transfer it back to the Main view form the settingsVC(this will be called in viewWillAppear
        } else {
            
        }
    }
    
    //This is a slightly different way to segue because it is a collection cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? ColorCollectionCell,
            let indexPath = colorCollection.indexPath(for: cell),
            let settingsVC = segue.destination as? SettingsSlidersVC else {
                fatalError("Did not segue to SettingsSliderVC") }
        let eachCell = crayonColors[indexPath.row]
        settingsVC.theCrayonColors = eachCell
    }
    
    
}

extension ColorListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crayonColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "thisColorCell", for: indexPath)
        let crayons = crayonColors[indexPath.row]
        cell.backgroundColor = UIColor(red: CGFloat(crayons.red/255), green: CGFloat(crayons.green/255), blue: CGFloat(crayons.blue/255), alpha: 1)
        //cell.setUpCell.text = crayons[indexPath.row]
       
        navigationItem.title = crayons.name
        return cell
    }
    
    
}
extension ColorListViewController: UICollectionViewDelegateFlowLayout {
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

extension ColorListViewController: UISearchBarDelegate {
    //        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //              guard let updatedUserQuery = searchBar.text else {
    //                  return
    //              }//this is not necessary you are being REDUNDANT!!
    //              userQuery = updatedUserQuery //Set the value of means equal
    //          }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            colorCollection.reloadData()
            return
        }
        userQuery = searchText
    }
}
