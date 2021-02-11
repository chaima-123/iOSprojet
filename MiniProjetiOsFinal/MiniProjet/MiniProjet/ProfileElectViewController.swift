//
//  ProfileElectViewController.swift
//  MiniProjet
//
//  Created by mac  on 14/12/2020.
//

import UIKit
import Cosmos

class ProfileElectViewController:  UIViewController , UITableViewDataSource,UITableViewDelegate, MyCellDelegate{
   
    
    var user:User?

    var ind :Int?
    
    let baseUrl = "http://192.168.1.14:3000"

  
    @IBOutlet weak var desc: UITextView!
    @IBAction func Sendmsg(_ sender: Any) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC
            newViewController?.userName = user!
              
        self.navigationController?.pushViewController(newViewController!, animated: true)
    }
    
    @IBAction func confirmer(_ sender: Any) {
        print(ind!,"!!!!!!!!!!!!!!!!!!!")
        
        updateComment(id:mang[ind!].id , contenu: CommentTxt.text!)
        fetchcomments()
        self.myTable.reloadData()
        CommentTxt.text! = ""

    }
    
    func btnCloseTapped(cell: CommentTableViewCell) {
        let indexPath = self.myTable.indexPath(for: cell)
       ind = (indexPath!.row)
        
        print(mang[indexPath!.row].dateCommentaire)
        CommentTxt.text = mang[indexPath!.row].contenu
    }
   
    func btnDeleteTapped(cell: CommentTableViewCell) {
        
    }
    
 
    

  
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var btnCommentaire: UIButton!
    @IBOutlet weak var btnRatingShow: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
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
    

    
    @IBAction func AddComment(_ sender: Any) {
            print("Creating user")
        Service.shared.AddComment(idPres: user!.id, idUser:idUser, userName:UserDefaults.standard.string(forKey: "firstname")! , contenu: CommentTxt.text! ,image: img!){ (res) in
            switch res {
                
                case.failure(let err):
                    print("Failed to add comment:", err
                    )
                case.success(let user):
                    print("updated with success")
                    self.fetchcomments()
                    self.myTable.reloadData()
            }
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let rate = UserDefaults.standard.double(forKey: "rate")

       
      cosmosView.rating = user!.rate
       //  print(z,"coucoucoucou")

        cosmosView.settings.fillMode = .precise

        cosmosView.didTouchCosmos = {rating in
           // print("Rate\(rating+self.user!.rate/2))")
           
            let alert = UIAlertController(title: "", message:  "Merci pour votre note!", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: { [self]
                                action in
                                self.updateRate(rate: (rating+self.user!.rate)/2)
                                cosmosView.rating = (rating+self.user!.rate)/2

                                
                            })
                            alert.addAction(closeAction)
                            self.present(alert, animated: true, completion: nil)        }
    
        

        print(UserDefaults.standard.string(forKey: "id_user")!)

        
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        
       // print(user!.firstName+"hiiiiiii "+user!.email)
        labelName.text = user!.firstName+" "+user!.lastName
        desc.text = user!.description

        self.btnCommentaire.applyGradient(colours: [.purple, .systemPurple])
        btnCommentaire.layer.masksToBounds = true
        btnCommentaire.layer.cornerRadius = 20

        let url = URL(string: "\(baseUrl)"+user!.image)!
        imgView.loadImge(withUrl: url)
        btnRatingShow.layer.masksToBounds = true

        self.btnRatingShow.applyGradient(colours: [.purple, .systemPurple])

        self.btnRatingShow.layer.cornerRadius = 20
       
        
        myTable.dataSource = self
        myTable.delegate = self
        self.myTable.transform    = CGAffineTransform(scaleX: 1, y: -1);
        fetchcomments()
     
    }
    
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

        //***************************action btn***************************************
        //btn.addTarget(self, action:selector(action), for: .touchUpInside)


        let imageView = cell.img
        
        let url = URL(string: "\(baseUrl)"+img!)!
        imageView!.loadImge(withUrl: url)

        editCom.text = mang[indexPath.row].contenu
        userName.text = mang[indexPath.row].userName
        dateCom.text = mang[indexPath.row].dateCommentaire

        print(idUser,mang[indexPath.row].idUser )
        
        if( idUser !=  mang[indexPath.row].idUser)
        {
    
         //   cell.btnModifier(<#T##sender: Any##Any#>)
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


    
}
