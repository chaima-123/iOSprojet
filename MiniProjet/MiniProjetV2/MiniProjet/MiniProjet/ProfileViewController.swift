//
//  ProfileViewController.swift
//  MiniProjet
//
//  Created by mac  on 05/12/2020.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user:User?
    var email:String?
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

       
        // print(email!+"hiiiiiii")
        
    }
     
    @IBOutlet  var starButtons: [UIButton]!

    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Rated \(sender.tag) stars.")
         
          for  button in starButtons {
              if button.tag <= sender.tag {
                  button.setBackgroundImage(UIImage(named: "star"), for: .normal)   //selectted
              } else {
                  button.setBackgroundImage(UIImage(named: "star.fill"), for: .normal)    //not selectted
              }
          }
          
    }
    
    

}
