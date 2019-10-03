//
//  AvatarPickerVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/28/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //variables
    var avatarType = AvatarType.dark //default avatar type
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    //CollectionView functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell
        {
            cell.configurecell(index: indexPath.item, avatarType: avatarType)
             return cell
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320{
            numOfColumns = 4
        }
        
        let padding : CGFloat = 40
        let spaceBetweenCells : CGFloat = 10
        let cellDiemension = ((collectionView.bounds.width-padding)-(numOfColumns-1)*spaceBetweenCells)/numOfColumns
        return CGSize(width: cellDiemension, height: cellDiemension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName ( avatarName: "dark\(indexPath.item)")
        }else{
          UserDataService.instance.setAvatarName ( avatarName: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    //IBActions
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segemntcontrolChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0{
            avatarType = AvatarType.dark
        }else{
            avatarType = AvatarType.light
        }
        collectionView.reloadData()
    }
}
