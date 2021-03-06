//
//  ViewController.swift
//  MiniProjet
//
//  Created by mac  on 12/11/2020.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController ,GIDSignInDelegate {
   
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error == nil {
            print(user.userID!)
            print(user.profile.name!)
            print(user.profile.email!)
        }

    }
    
    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
   
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func login() {
        Service.shared.login(email: emailText.text!, password: password.text!) { (res) in
            switch res {
            case .failure(let err):
                print("Failed to find user:", err
                )

            case .success(let user):
//                print(posts)
          //  self.mang = mang
                if( user.message == "succed")
                { //self.performSegue(withIdentifier: "mSegue", sender: self)

                    let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "map") as? MapViewController
                                        newViewController?.modalPresentationStyle = .fullScreen
                                        self.present(newViewController!, animated:true, completion:nil)
                   // print(user)
                    UserDefaults.standard.set(user.id, forKey: "id_user")
                    UserDefaults.standard.set(user.firstName, forKey: "firstname")
                    UserDefaults.standard.set(user.lastName, forKey: "lastname")
                    UserDefaults.standard.set(user.tel, forKey: "tel")
                    UserDefaults.standard.set(user.email, forKey: "email")
                    UserDefaults.standard.set(user.image, forKey: "image")
                    UserDefaults.standard.set(user.rate, forKey: "rate")
                    
                    Service.shared.updateStatus(userName:user.firstName ) { (res) in
                        switch res {
                        case .failure(let err):
                            print("Failed to fetch posts:", err)
                       
                        case .success(let mang):
            //                print(posts)
                
                            print("okk")
                        }
                    }

                }
    
                else
                {
                    self.toastMessage(user.message)
                    print  (user.message)              }
            
            }
        }
    }
 
    
  
    @IBAction func loginAction(_ sender:Any)
    {
        login()

    }
    
    
    func toastMessage(_ message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)

        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)

        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 40)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

        UIView.animate(withDuration: 1, animations: {
            messageLbl.alpha = 0
        }) { (_) in
            messageLbl.removeFromSuperview()
        }
        }
    }
    
    

}

