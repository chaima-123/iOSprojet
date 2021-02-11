//
//  DemandeTraitementViewController.swift
//  MiniProjet
//
//  Created by mac  on 09/01/2021.
//

import UIKit

class DemandeTraitementViewController: UIViewController {
    var service:ServiceModel?


    @IBOutlet weak var labelDescr: UITextView!
    
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var btnAccepter: UIButton!
    @IBOutlet weak var btnRefuser: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDescr.text = service!.description
        labelType.text = service!.type
        labelName.text = service!.client_name
        
        myView.layer.shadowRadius = 3
                myView.layer.shadowOffset = .zero
                myView.layer.shadowOpacity = 0.4
        myView.layer.cornerRadius = 20
        
        self.btnAccepter.applyGradient(colours: [.purple, .systemPurple])
        btnAccepter.layer.masksToBounds = true
        btnAccepter.layer.cornerRadius = 10
        
        self.btnRefuser.applyGradient(colours: [.purple, .systemPurple])
        btnRefuser.layer.masksToBounds = true
        btnRefuser.layer.cornerRadius = 10

    }

    @IBAction func AccepterDemande(_ sender: Any)
    {
        Service.shared.ConfirmerDemande(idService: service!.id, idPres: service!.client_id){(res) in
            switch res
            {
            case .failure(let err):
                print("Failed to accept demande:", err)
            case .success(let services):
                let alert = UIAlertController(title: "", message:  "Un email de confirmation est envoyé à votre client!", preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "D'accord", style: UIAlertAction.Style.cancel, handler: { [self]
                                    action in
                                 
                                    
                                })
                                alert.addAction(closeAction)
               self.present(alert, animated: true, completion: nil)
              
            print(services)
            }
        }
        
    }
    
    @IBOutlet weak var myView: UIView!
    @IBAction func RefuserDemande(_ sender: Any)
    {
        Service.shared.RefuserDemande(idService: service!.id, idPres: service!.client_id){(res) in
            switch res
            {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let services):
                let alert = UIAlertController(title: "", message:  "Un email de refus est envoyé à votre client!", preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "D'accord", style: UIAlertAction.Style.cancel, handler: { [self]
                                    action in
                                 
                                    
                                })
                                alert.addAction(closeAction)
               self.present(alert, animated: true, completion: nil)
              
              
            print(services)
            }
        }
    }
    
    
}
