//
//  ViewController.swift
//  MiniProjet
//
//  Created by mac  on 12/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
 
    }
    
    @objc fileprivate func login() {
        Service.shared.login(email: "chaima.besbes2@gmail.com", password: "1253") { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err
                )

            case .success(let user):
//                print(posts)
          //  self.mang = mang
                if( user.message == "succed")
                { self.performSegue(withIdentifier: "mSegue", sender: user)

                    print(user)}
                
                else
                {

                    print  ("ouuuupssss")              }
            
            }
        }
    }
 
    
  
    @IBAction func loginAction(_ sender:Any)
    {
        login()
    }
    
}

