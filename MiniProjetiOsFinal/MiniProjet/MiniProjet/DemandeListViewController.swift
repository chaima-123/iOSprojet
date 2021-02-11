//
//  DemandeListViewController.swift
//  MiniProjet
//
//  Created by mac  on 03/01/2021.
//

import UIKit

class DemandeListViewController: UIViewController , UITableViewDataSource,UITableViewDelegate {
    
    var services:[ServiceModel] = []

   
    @IBOutlet weak var myTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTable.dequeueReusableCell(withIdentifier: "cellService")
        let cnt = cell?.contentView
        let labelName = cnt?.viewWithTag(2) as! UILabel
        let labelDesc = cnt?.viewWithTag(3) as! UILabel
        labelName.text = services[indexPath.row].client_name
        labelDesc.text = services[indexPath.row].type
        
        return cell!
    }
    
    let centerView = UIView()
    let label = UILabel()

    @IBOutlet weak var menuButtom: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.string(forKey:"role")! == "Client")
        {
       
            myTable.isHidden = true
                
            centerView.translatesAutoresizingMaskIntoConstraints = false

            centerView.layer.shadowRadius = 3
            centerView.layer.shadowOffset = .zero
            centerView.layer.shadowOpacity = 0.4
            self.view.addSubview(centerView)
            

            let label = UITextView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            label.center = CGPoint(x: 160, y: 285)
               label.textAlignment = .center
          
            label.text = "Devenez une prestataire et proposez vos propres services en modifiant votre profile. "
           centerView.addSubview(label)
            
          

        
        }
        else
        {
        myTable.dataSource = self
        myTable.delegate = self
            fetchServices()}
        if self.revealViewController() != nil {
            menuButtom.target = self.revealViewController()
            menuButtom.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
     return 73
    }
    
    @objc fileprivate func fetchServices() {
    
        if(UserDefaults.standard.string(forKey:"role")! == "prestataire")
        {
        Service.shared.showService( prestataire_id:UserDefaults.standard.integer(forKey: "id_user")){(res) in
            self.myTable.refreshControl?.endRefreshing()
            switch res
            {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let services):
                self.services = services
                self.myTable.reloadData()
                print(services)
            }
        }
        }
        else
        {
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let indexPath = myTable.indexPathForSelectedRow
        let index = indexPath?.row
        let service = services[index!]
        let dest = segue.destination as? DemandeTraitementViewController
        dest?.service = service
    }


}
