//
//  ShowPlombViewController.swift
//  MiniProjet
//
//  Created by mac  on 10/12/2020.
//

import UIKit

class ShowPlombViewController:UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var mang:[User] = []
    var user:User?
    
    let adress = UserDefaults.standard.string(forKey: "adress")

    
    var data = ["schedule","schedule"]
    
    @objc fileprivate func fetchPosts() {
//        print(UserDefaults.standard.string(forKey: "aa")!)
        print ("!!!!!!!!",UserDefaults.standard.string(forKey: "adress")!)

        Service.shared.fetchPlomb( adress :UserDefaults.standard.string(forKey: "adress")!) { (res) in
            self.myTable.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let mang):
//                print(posts)
                self.mang = mang
                self.myTable.reloadData()
                print(mang)
            }
        }
    }
  


    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        fetchPosts()
        //print(UserDefaults.standard.string(forKey: "aa")!)

        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTable.dequeueReusableCell(withIdentifier: "CELL")
        let cnt = cell?.contentView
        //let labelLastName = cnt?.viewWithTag(3) as! UILabel
      let labelFirstName = cnt?.viewWithTag(2) as! UILabel
        let labelRole = cnt?.viewWithTag(4) as! UILabel

        let imageView = cnt?.viewWithTag(1) as! UIImageView
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
       
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        let url = URL(string: "http://192.168.1.3:3000"+mang[indexPath.row].image)!
        imageView.loadImge(withUrl: url)
        

     //   imageView.image = UIImage(named: data[indexPath.row])
        
        labelFirstName.text = mang[indexPath.row].firstName+" "+mang[indexPath.row].lastName
        //labelFirstName.text = mang[indexPath.row].lastName
        labelRole.text = mang[indexPath.row].profession
        return cell!
        
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "proSegue", sender: indexPath)
            }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let indexPath = myTable.indexPathForSelectedRow
        let index = indexPath?.row
        let user_id = mang[index!]
        let dest = segue.destination as? ProfileViewController
        dest?.user = user_id
      //  dest.movieName = movie
    
    }
    
}




