//
//  ProfileViewController.swift
//  MiniProjet
//
//  Created by mac  on 05/12/2020.
//

import UIKit
import Cosmos
import CoreData

class ProfileViewController:  UIViewController , UITableViewDataSource,UITableViewDelegate, MyCellDelegate {
    

    
    var user:User?

    var ind :Int?

    @IBOutlet weak var labelRole: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var btnCommentaire: UIButton! 
    @IBOutlet weak var imgView: UIImageView!
        
    @IBOutlet weak var desc: UITextView!
    var test:Bool = false

    @IBAction func confirmer(_ sender: Any) {
        self.fetchcomments()
        self.myTable.reloadData()

        if(test == true){
        updateComment(id:mang[ind!].id , contenu: CommentTxt.text!)
            self.fetchcomments()
            //self.loadView()
        self.myTable.reloadData()
       CommentTxt.text! = ""
            
        }
        else
        {
            print("Creating comment")
            Service.shared.AddComment(idPres: user!.id, idUser:idUser, userName:UserDefaults.standard.string(forKey: "firstname")! , contenu:  CommentTxt.text!,image: img! ){ (res) in
            switch res {
                case.failure(let err):
                    print("Failed to add comment:", err
                    )
                case.success(let user):
                    print("added with success")
                    self.fetchcomments()
                    self.myTable.reloadData()
            }
    
            }

            }

    }
    
    func btnCloseTapped(cell: CommentTableViewCell)
    {
        let indexPath = self.myTable.indexPath(for: cell)
       ind = (indexPath!.row)
        
        print(mang[indexPath!.row].dateCommentaire)
        CommentTxt.text = mang[indexPath!.row].contenu
        test = true
        
    }
    
 
    
    func btnDeleteTapped(cell: CommentTableViewCell) {
        let indexPath = self.myTable.indexPath(for: cell)
       ind = (indexPath!.row)
        
       let refreshAlert = UIAlertController(title: "Confirmation", message: "Etes vous sur de supprimer ce commentaire?.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { [ind] (action: UIAlertAction!) in
          print("Handle Ok logic here")
            Service.shared.DeleteComment(id: self.mang[ind!].id ){ (res) in
                switch res {
                    
                    case.failure(let err):
                        print("Failed to add comment:", err
                        )
                    case.success(let x):
                        print("deleted with success")
                        self.fetchcomments()
                        self.myTable.reloadData()
                }
            }
          }))

        refreshAlert.addAction(UIAlertAction(title: "Non", style: .cancel, handler: { (action: UIAlertAction!) in
         
          }))

        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       cosmosView.rating = user!.rate

         cosmosView.settings.fillMode = .precise

         cosmosView.didTouchCosmos = {rating in
            
             let alert = UIAlertController(title: "", message:  "Merci pour votre note!", preferredStyle: .alert)
             let closeAction = UIAlertAction(title: "Fermer", style: UIAlertAction.Style.cancel, handler: { [self]
                                 action in
                                 self.updateRate(rate: (rating+self.user!.rate)/2)
                                 cosmosView.rating = (rating+self.user!.rate)/2

                                 
                             })
                             alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)  }
        print(UserDefaults.standard.string(forKey: "id_user")!)
        
       // print(user!.firstName+"hiiiiiii "+user!.email)
        labelName.text = user!.firstName+" "+user!.lastName
        desc.text = user!.description
        
     
        Service.shared.findUser(id: UserDefaults.standard.integer(forKey: "id_user")){ (res) in
            switch res {
            
            case.failure(let err):
                print("Failed to update user:", err
                )

            case.success(let user):
                print("updated with success")
                let url = URL(string: "http://172.20.10.2:3000"+user.image)!
                self.imgView.loadImge(withUrl: url)
                
            }
        }
    

       
        myTable.dataSource = self
        myTable.delegate = self
        self.myTable.transform    = CGAffineTransform(scaleX: 1, y: -1);
        fetchcomments()
     
    }



    @IBOutlet weak var CommentTxt: UITextField!
    var mang:[Comment] = []
    
    var data = ["schedule","schedule"]
    
    @IBOutlet weak var myTable: UITableView!
    

  
    @IBOutlet weak var cosmosView: CosmosView!
   
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
   
   let name = UserDefaults.standard.string(forKey: "firstname")
    let img = UserDefaults.standard.string(forKey: "image")
    let idUser = UserDefaults.standard.integer(forKey: "id_user")
    


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTable.dequeueReusableCell(withIdentifier: "CELLS") as! CommentTableViewCell
        cell.transform = self.myTable.transform;

        
        myTable.rowHeight = 80
        cell.viewCell.layer.borderWidth = 0.1
        cell.viewCell.layer.shadowRadius = 12
        cell.viewCell.layer.cornerRadius = 15
        
        cell.img.layer.borderWidth = 0.5
        cell.img.layer.masksToBounds = false
        cell.img.layer.borderColor = UIColor.black.cgColor
      
        cell.img.layer.cornerRadius = cell.img.frame.height/2
        cell.img.clipsToBounds = true
        let cnt = cell.contentView
        
       // let comment = cnt.viewWithTag(1) as! UILabel
        let userName = cnt.viewWithTag(2) as! UILabel
        let dateCom = cnt.viewWithTag(3) as! UILabel
        let editCom = cnt.viewWithTag(4) as! UITextField
        let btn = cnt.viewWithTag(5) as! UIButton
        let id = mang[indexPath.row].id

        cell.delegate = self

      

        let imageView = cell.img
        
        let url = URL(string: "http://172.20.10.2:3000"+img!)!
        imageView!.loadImge(withUrl: url)

        editCom.text = mang[indexPath.row].contenu
        userName.text = mang[indexPath.row].userName
        dateCom.text = mang[indexPath.row].dateCommentaire

        print(idUser,mang[indexPath.row].idUser )
        
        if( idUser !=  mang[indexPath.row].idUser)
        {
    
            cell.commentaire.isEnabled = false
            cell.btnModif.isHidden = true
           cell.btnSupp.isHidden = true

        }
        //print("tag!!!!!!!!!!!",mang[indexPath.row].contenu)
        return cell
        
    }
    
     private func action(id :Int , contenu :String ) {
        Service.shared.UpdateComments(id:id, contenu: contenu) { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let user):
//                print(posts)
                print(user)
            }
        }
    }
    
    @objc fileprivate func fetchcomments() {
        Service.shared.ShowComments(idPres: user!.id ) { (res) in
            self.myTable.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let mang):
//                print(posts)
                self.mang = mang
                self.myTable.reloadData()
                print(mang)
            }
        }
    }
    
    @objc fileprivate func updateRate(rate:Double) {
        Service.shared.UpdateRate(idPres: user!.id , rate:rate) { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let user):
//                print(posts)
                print(user)
            }
        }
    }
    
    @objc fileprivate func updateComment(id :Int , contenu :String) {
        Service.shared.UpdateComments(id:id, contenu: contenu) { (res) in
            switch res {
            case .failure(let err):
                print("Failed to update comment:", err)
            case .success(let user):
//                print(posts)
                print(user)
            }
        }
    }
    


       //Need this method for delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == UITableViewCell.EditingStyle.delete {
               myTable.reloadData()
           }
       }


    @IBAction func DemanderService(_ sender: Any) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "service") as? DemandeServViewController
            newViewController?.userPro = user!
              
        self.navigationController?.pushViewController(newViewController!, animated: true)
        
    }
    
    
    @IBAction func addFavorite(_ sender: Any) {
        if checkUser() {
            let alert = UIAlertController(title: "Alerte", message: "Ce prestataire existe déja dans vos favoris", preferredStyle: .alert)
            let action = UIAlertAction(title: "D'accord", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }else{
            insertItem()
        }
  
    
    }
    
    
    func insertItem()   {
        // les 3 etape hadhom ykounou fi n'import methode mtaa crud
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managerContext = persistentContainer.viewContext  // tableau de nsManagetobject
        
        // bech tekhou esm el entity
        let entityDescription = NSEntityDescription.entity(forEntityName: "Prestataire", in: managerContext)
        
        //nasn3ou instance men NsmanagetObject
        let object = NSManagedObject(entity: entityDescription!, insertInto: managerContext)
        
        // bech tekhou esm el attribut
        object.setValue(user!.id, forKey: "id")
        object.setValue(user!.firstName, forKey: "name")
        object.setValue(user!.image, forKey: "img")
        object.setValue(user!.profession, forKey: "profession")
        object.setValue(user!.tel, forKey: "tel")



        
        do {
            try          managerContext.save()
            "Insert succed"
            let alert = UIAlertController(title: "", message:  "Ajoutée aux favoris!", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Fermer", style: UIAlertAction.Style.cancel, handler: { [self]
                                action in
                            })
                            alert.addAction(closeAction)
           self.present(alert, animated: true, completion: nil)


        } catch  {
            "Insert error"
        }
        
    }
    
    func checkUser() -> Bool {
        
        var movieExist = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Prestataire")// select* from movie
        let predicate = NSPredicate(format: "id = %d" ,  user!.id)//CONDITION WHERE
        //format = bech bech nkaren
        //%@ pour comparer des string et %d pour comparer des int
        request.predicate = predicate
        do {
            //bech naamlou contenaire nestokiw fiha el requette
           let result = try managedContext.fetch(request)
            if result.count > 0 {
                movieExist = true
                print("Movie exists !")            }
        } catch  {
            print("fetching error")
        }
        
        return movieExist
        
    }

    
}



    
    


