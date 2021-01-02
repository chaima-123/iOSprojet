//
//  UserProfileViewController.swift
//  MiniProjet
//
//  Created by mac  on 07/12/2020.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var menuButtom: UIBarButtonItem!
    @IBOutlet weak var btnModif: UIButton!
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var errorName: UILabel!
    
    @IBOutlet weak var errorLastName: UILabel!
    
    @IBOutlet weak var errorTel: UILabel!
    
    @IBOutlet weak var errorEmail: UILabel!
    var test:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: "image"))
        
        let url = URL(string: "http://localhost:3000"+UserDefaults.standard.string(forKey : "image")!)!
        imgView.loadImge(withUrl: url)
        
       
        firstName.text = UserDefaults.standard.string(forKey: "firstname")
        lastName.text = UserDefaults.standard.string(forKey: "lastname")
        tel.text = UserDefaults.standard.string(forKey: "tel")
        email.text = UserDefaults.standard.string(forKey: "email")

        self.btnModif.applyGradient(colours: [.purple, .systemPurple])
        btnModif.layer.masksToBounds = true
        btnModif.layer.cornerRadius = 25

        


        if self.revealViewController() != nil {
            menuButtom.target = self.revealViewController()
            menuButtom.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        myView.layer.shadowRadius = 3
                myView.layer.shadowOffset = .zero
                myView.layer.shadowOpacity = 0.4
        
    }
    

    @IBOutlet weak var myView: UIView!
    @IBAction func updateProfile(_ sender: Any) {
        update()
    }
    
    @objc fileprivate func update() {
        print("Creating user")
        if (( firstName.text!.isEmpty)  )
             {
                 errorName.isHidden = false
                 errorName.text="Ce champ est obligat oire!"
                 self.test = true

             }
             else{
                 errorName.isHidden = true
                 errorLastName.isHidden = true
                self.test = false

             }
        
        if ((  lastName.text!.isEmpty) )
                 {
                     errorLastName.isHidden = false
                     errorLastName.text="Ce champ est obligatoire!"
                     self.test = true

                 }
                 else{
                     errorName.isHidden = true
                     errorLastName.isHidden = true
                    self.test = false

                 }
        
        
        if(test == false)
        {
        Service.shared.updateUser(id :UserDefaults.standard.integer(forKey: "id_user"),
                                  firstName: firstName.text!,
                                  lastName:lastName.text!, email: email.text!,
                                  tel : tel.text!){ (res) in
            switch res {
            
            case.failure(let err):
                print("Failed to update user:", err
                )

            case.success(let user):
                print("updated with success")
                    //self.toastMessage(user.message)
           
            }
        }
    }
    }
}



extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
         gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
