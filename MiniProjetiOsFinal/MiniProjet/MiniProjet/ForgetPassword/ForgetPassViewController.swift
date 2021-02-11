//
//  ForgetPassViewController.swift
//  MiniProjet
//
//  Created by mac  on 14/12/2020.
//

import UIKit

class ForgetPassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.layer.shadowRadius = 3
                myView.layer.shadowOffset = .zero
                myView.layer.shadowOpacity = 0.4
        myView.layer.cornerRadius = 20
        
        self.btnEmail.applyGradient(colours: [.purple, .systemPurple])
        btnEmail.layer.masksToBounds = true
        
    }
    
    
    
    @IBOutlet weak var textEmail: UITextField!
    
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var myView: UIView!
    
    
    @IBAction func sendMail(_ sender: Any)
    {
        ServicePassword.shared.sendEmail(email: textEmail.text! ){ (res) in
            switch res {
            case .failure(let err):
                print("Failed to find user:", err
                )

            case .success(let user):
//                print(posts)
          //  self.mang = mang
            //    print(user)

                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "confCode") as? ConfCodeViewController
                newViewController?.modalPresentationStyle = .custom
                                    newViewController?.user = user
                                    self.present(newViewController!, animated:true, completion:nil)

                
        }
    }
}

}
