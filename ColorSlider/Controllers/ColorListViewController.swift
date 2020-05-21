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
        didSet {
            if userQuery.isEmpty { //if the user types and cancels it then the search bar is empty which THEN the tableview repopulates
                //crayonColors = Crayon.allTheCrayons //this repopulates the data
                colorCollection.reloadData()//i think this works better
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
        updateAppColor()
    }
//    override func viewWillAppear(_ animated: Bool) { //will be
//        super.viewWillAppear(true)
//        updateAppColor()
//    }
    
  
    private func updateAppColor() { //when you store something to userdefaults it will be ANY unless you TYPECAST it
        if let colorName = UserDefaults.standard.object(forKey: AppKey.appColorKey) as? String ,
            let red = UserDefaults.standard.object(forKey: AppKey.red) as? CGFloat,
            let blue = UserDefaults.standard.object(forKey: AppKey.blue) as? CGFloat,
            let green = UserDefaults.standard.object(forKey: AppKey.green) as? CGFloat {
            
            navigationItem.title = colorName
            colorCollection.backgroundColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
        } else {
            navigationItem.title = "Pick a background color"
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
        guard let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "thisColorCell", for: indexPath) as? ColorCollectionCell else { fatalError("Could not downcast to ColorCollectionCell")}
        let crayons = crayonColors[indexPath.row]
        cell.setUpCell(eachCell: crayons)
       
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationItem.title = crayonColors[indexPath.row].name
        UserDefaults.standard.set(crayonColors[indexPath.row].name, forKey: AppKey.appColorKey)
        UserDefaults.standard.set(crayonColors[indexPath.row].red, forKey: AppKey.red)
        UserDefaults.standard.set(crayonColors[indexPath.row].blue, forKey: AppKey.blue)
        UserDefaults.standard.set(crayonColors[indexPath.row].green, forKey: AppKey.green)
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
            searchBar.resignFirstResponder()//lets see if this gets rid of the keyboard
            return
        }
        userQuery = searchText
    }
}
