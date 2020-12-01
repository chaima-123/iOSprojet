//
//  CollectionViewController.swift
//  MiniProjet
//
//  Created by mac  on 23/11/2020.
//

import UIKit

class CollectionViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
        @IBOutlet weak var myCollectionView: UICollectionView!
        
        let array:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

        override func viewDidLoad() {
            super.viewDidLoad()

            let itemSize = UIScreen.main.bounds.width/3 - 2
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
            
            myCollectionView.collectionViewLayout = layout
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        
        //Number of views
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return array.count
        }
        
      //Populate view
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
            cell.myImageView.image = UIImage(named: array[indexPath.row] + ".JPG")
            return cell
        }

    }

