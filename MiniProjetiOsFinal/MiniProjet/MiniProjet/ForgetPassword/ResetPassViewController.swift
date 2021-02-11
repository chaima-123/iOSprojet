//
//  ResetPassViewController.swift
//  MiniProjet
//
//  Created by mac  on 14/12/2020.
//

import UIKit

class ResetPassViewController: UIViewController {
    
    var  user:User?

    @IBOutlet weak var labelError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        myView.layer.shadowRadius = 3
                myView.layer.shadowOffset = .zero
                myView.layer.shadowOpacity = 0.4
        myView.layer.cornerRadius = 20
        
        
        self.btnConf.applyGradient(colours: [.purple, .systemPurple])
        btnConf.layer.masksToBounds = true
    
        self.bigView.applyGradient(colours: [.purple, .systemPurple])
        bigView.layer.masksToBounds = true
        bigView.layer.cornerRadius = 30

    }

    
    @IBOutlet weak var myView: UIView!
  
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var btnConf: UIButton!
    
    
    @IBOutlet weak var pass1: UITextField!
    
    @IBOutlet weak var pass2: UITextField!
    
    
    @IBAction func Confirmer(_ sender: Any) {
        if(pass1.text! == pass2.text!)
        {
            labelError.isHidden = true

            ServicePassword.shared.updatePassword(id:user!.id , password:pass2.text! ){ (res) in
                switch res {
                case .failure(let err):
                    print("Failed to find user:", err
                    )

                case .success(let user):
    //                print(posts)
              //  self.mang = mang
                    print(user)

                    
                    let alert = UIAlertController(title: "Sucées", message:  "Votre mot de passe est modifié avec sucées", preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Fermer", style: UIAlertAction.Style.cancel, handler: { [self]
                                        action in
                        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController
                                            newViewController?.modalPresentationStyle = .fullScreen
                                            self.present(newViewController!, animated:true, completion:nil)
                                    })
                                    alert.addAction(closeAction)
                    self.present(alert, animated: true, completion: nil)

                }
            }
            
        }
        else
        {
            labelError.isHidden = false

            
        }
    }
    
 
}
