//
//  DemandeDetailViewController.swift
//  MiniProjet
//
//  Created by mac  on 09/01/2021.
//

import UIKit

class DemandeDetailViewController: UIViewController {

    var service:ServiceModel?
    var user:Int?

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var btnVisiterProfile: UIButton!
    
    
    @IBOutlet weak var labelNamePres: UILabel!
    
    @IBOutlet weak var labdelDate: UILabel!
    
    @IBOutlet weak var labelEtat: UILabel!
    @IBOutlet weak var labelType: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.btnVisiterProfile.applyGradient(colours: [.purple, .systemPurple])
        btnVisiterProfile.layer.masksToBounds = true
        btnVisiterProfile.layer.cornerRadius = 10
        
        
        
        myView.layer.shadowRadius = 3
                myView.layer.shadowOffset = .zero
                myView.layer.shadowOpacity = 0.4
        myView.layer.cornerRadius = 20
        
        labelNamePres.text = service!.prestatire_name
        labelEtat.text = service!.etat
        labelType.text = service!.type

        
        
    }
    
    @IBAction func visterProfile(_ sender: Any) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "profile") as?
            ProfileViewController
        Service.shared.findUser(id :service!.prestatire_id){(res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let mang):
                print(mang)
                newViewController?.user = mang
                self.navigationController?.pushViewController(newViewController!, animated: true)

                print(mang)
            }
        }
        
              
        
    }
    
    @objc fileprivate func fetchUser() {
        Service.shared.findUser(id :UserDefaults.standard.integer(forKey: "id")){(res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let mang):
//                print(posts)
                print(mang)
            }
        }
    }
    
    @IBAction func AnnulerDemande(_ sender: Any) {
    }
    
}
