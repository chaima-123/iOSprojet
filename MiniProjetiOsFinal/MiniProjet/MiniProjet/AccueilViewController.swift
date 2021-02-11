//
//  AccueilViewController.swift
//  MiniProjet
//
//  Created by mac  on 28/12/2020.
//

import UIKit

class AccueilViewController: UIViewController , UITableViewDelegate, UITableViewDataSource


{
    var data = ["electricien","plomberie","menuiserie","peinture"]
    
    @IBOutlet weak var myTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "service")
        let cnt = cell?.contentView
        let imageView = cnt?.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: data[indexPath.row])
        
        return cell!
    
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // performSegue(withIdentifier: "mSegue", sender: indexPath)
        
    }
}
