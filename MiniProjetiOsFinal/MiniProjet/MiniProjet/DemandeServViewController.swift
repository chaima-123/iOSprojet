//
//  DemandeServViewController.swift
//  MiniProjet
//
//  Created by mac  on 02/01/2021.
//

import UIKit

class DemandeServViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var btnDemande: UIButton!
    var userPro:User?

    
    
    @IBOutlet weak var myView: UIView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var dataSource = [String]()
    var selectedButton = UIButton()
    var address:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        myView.layer.shadowRadius = 3
                myView.layer.shadowOffset = .zero
                myView.layer.shadowOpacity = 0.4
        myView.layer.cornerRadius = 20
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
 
    }
    
    @IBOutlet weak var btnSelectVille: UIButton!
    @IBOutlet weak var descText: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
         return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 50
      }
    
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
          removeTransparentView()
          address = dataSource[indexPath.row]
      }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)

        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5

        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))

        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height:200)
            
        }, completion: nil)
    }
    
    @objc func removeTransparentView()
    {
        let frames = selectedButton.frame

           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
               self.transparentView.alpha = 0
               self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height:0)
           }, completion: nil)
   }

    @IBAction func btnSelectVille(_ sender: Any)
    {
        dataSource = ["Réparation", "Installation"]
        selectedButton = btnSelectVille
        addTransparentView(frames: btnSelectVille.frame)
        
    }
    
    let name = UserDefaults.standard.string(forKey: "firstname")
     let lastname = UserDefaults.standard.string(forKey: "lastName")
     let idUser = UserDefaults.standard.integer(forKey: "id_user")

    @IBAction func EnvoyerDemande(_ sender: Any)
    {
        print(userPro!.lastName)
        addDemande()
        
    }
    
    
    @objc fileprivate func addDemande() {
        
        Service.shared.addService(client_id: idUser, client_name: name!, prestatire_id: userPro!.id, prestatire_name: userPro!.firstName, type: address, description: descText.text!)
        
{
            (res) in
                switch res {

                case .failure(let err):
                    print("Failed to add service", err
                        )

                case .success(let user):
                    print(user)

                }
        
        
        
    }
    
    
    
}


}
