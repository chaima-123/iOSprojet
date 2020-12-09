//
//  HomeViewController.swift
//  MiniProjet
//
//  Created by mac  on 29/11/2020.
//

import UIKit

class HomeViewController: UIViewController {

    let transiton = SlideInTransition()
       var topView: UIView?
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
       override func viewDidLoad() {
           super.viewDidLoad()
       
        
    
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
       
       }

    

    
    
    
   }
