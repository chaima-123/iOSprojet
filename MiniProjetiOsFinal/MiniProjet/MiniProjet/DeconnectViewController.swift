//
//  DeconnectViewController.swift
//  MiniProjet
//
//  Created by mac  on 13/01/2021.
//

import UIKit

class DeconnectViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()

            let alert = UIAlertController(title: "Déconnexion", message:  "Se déconnecter du compte ", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: {
                action in    print("error")
                
                let defaults = UserDefaults.standard
                   defaults.removeObject(forKey: "id_user")
                defaults.removeObject(forKey: "isLogin")

                

                  // _ = navigationController?.popViewController(animated: true)

                //_ = self.navigationController?.popToRootViewController(animated: true)
                
                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController
                newViewController?.modalPresentationStyle = .fullScreen

                self.present(newViewController!, animated: true)
                
                
            })
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        

       
        

    }
