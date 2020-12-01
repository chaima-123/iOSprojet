//
//  ViewControllerInscri.swift
//  MiniProjet
//
//  Created by mac  on 21/11/2020.
//

import UIKit

class CellClass: UITableViewCell {
    
}

class ViewControllerInscri: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var dataSource = [String]()
    var address:String = ""

    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtConfPass: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtTel: UITextField!
        
    @IBOutlet weak var adress: UIButton!
    
    
    @objc fileprivate func handleCreatePost() {
        print("Creating user")
        
        Service.shared.createUser(firstName: txtFirstName.text!,
                                lastName: txtLastName.text!,
                                email: txtemail.text!,
                                tel : txtTel.text!,
                                city: address) { (err) in
            if let err = err {
                print("Failed to create post object:", err)
                return
            }
            
            print("Finished creating user")
         
        }
    }

    @IBAction func subscribe(_ sender: Any) {
        
        handleCreatePost()
    }
    
    
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
    

    @IBOutlet weak var btnSelectVille: UIButton!
    
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")

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
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame

           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
               self.transparentView.alpha = 0
               self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height:0)
           }, completion: nil)
       }

    
    
    @IBAction func btnSelectVille(_ sender: Any) {
        dataSource = ["Monastir", "sousse", "Mahdia", "Mahdia", "Mahdia", "Mahdia", "Mahdia"]
        selectedButton = btnSelectVille
        addTransparentView(frames: btnSelectVille.frame)
    }
    
    

}

