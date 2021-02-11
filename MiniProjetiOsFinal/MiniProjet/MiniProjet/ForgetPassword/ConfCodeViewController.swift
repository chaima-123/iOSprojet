//
//  ConfCodeViewController.swift
//  MiniProjet
//
//  Created by mac  on 14/12/2020.
//

import UIKit

class ConfCodeViewController: UIViewController {

    
    var  user:User?
    @IBOutlet weak var codeText: UITextField!
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var btnConf: UIButton!
    
    @IBOutlet weak var codeEroné: UILabel!
    @IBAction func Confirmer(_ sender: Any) {
        print(user!.resetPasswordToken)
        
        if(codeText.text ==  user?.resetPasswordToken )
        {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "change") as? ResetPassViewController
                                newViewController?.modalPresentationStyle = .fullScreen
                                newViewController?.user = user
                                self.present(newViewController!, animated:true, completion:nil)
            
        }
        else
        {
            codeEroné.text! = "Code erroné"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user!)

        myView.layer.shadowRadius = 3
                myView.layer.shadowOffset = .zero
                myView.layer.shadowOpacity = 0.4
        myView.layer.cornerRadius = 20
        self.btnConf.applyGradient(colours: [.purple, .systemPurple])
        btnConf.layer.masksToBounds = true
        
        
    }
    

}
