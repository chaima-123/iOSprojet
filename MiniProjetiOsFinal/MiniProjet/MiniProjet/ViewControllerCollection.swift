//
//  ViewControllerCollection.swift
//  MiniProjet
//
//  Created by mac  on 22/11/2020.
//

import UIKit
import CoreData

class ViewControllerCollection:UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var images = [String]()
    var names = [String]()
    var professions = [String]()
    var tels = [String]()



    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let array:[String] = ["1", "2", "3","1"]
    override func viewDidLoad() {
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        super.viewDidLoad()
        fetchData()
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
        return names.count
    }
    
  //Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let url = URL(string: "http://192.168.0.2:3000"+images[indexPath.row])!
        cell.img.loadImge(withUrl: url)
        cell.label.text = names[indexPath.row]
      //  cell.labelProfess.text = professions[indexPath.row]
        //cell.labelTel.text = tels[indexPath.row]


        return cell
    }
    
    
    func fetchData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Prestataire")
        do {
            
            let result = try managedContext.fetch(request)



            for item in result {
                images.append(item.value(forKey: "img") as! String)
                names.append(item.value(forKey: "name") as! String)
               // professions.append(item.value(forKey: "profession") as! String)
               // tels.append(item.value(forKey: "tel") as! String)


            }
            
        } catch  {
            
            print("Fetching error !")
        }
        
    }
    
    
}
