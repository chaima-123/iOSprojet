//
//  ViewControllerInscri.swift
//  MiniProjet
//
//  Created by mac  on 21/11/2020.
//

import UIKit
import Alamofire

class CellClass: UITableViewCell {
    
}

class ViewControllerInscri: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
    
    
    @IBAction func btnSelectImage(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                {
                    let myPickerController = UIImagePickerController()
                    myPickerController.delegate = self;
                    myPickerController.sourceType = .photoLibrary
                    self.present(myPickerController, animated: true, completion: nil)
                }
    }
    @objc fileprivate func handleCreatePost() {
        print("Creating user")
        
        Service.shared.createUser(firstName: txtFirstName.text!,
                                lastName: txtLastName.text!,
                                email: txtemail.text!,
                                tel : txtTel.text!,
                                password: txtPassword.text!,
                                city: address) { (res) in
            switch res {
            
            case .failure(let err):
                print("Failed to find user:", err
                )

            case .success(let user):
                    self.toastMessage(user.message)
           
            }
        }
        
        
        Service.shared.lastRecord() { (res) in
            switch res {
            
            case .failure(let err):
                print("Failed to find user:", err
                )

            case .success(let userr):
                self.uploadImage(file:userr._id)
        }
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
    
    
    @IBOutlet weak var imgView: UIImageView!
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
    

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
       {
           if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               self.imgView.image = image
           }else{
               debugPrint("Something went wrong")
           }
           self.dismiss(animated: true, completion: nil)
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    

    
    func uploadImage(file : String)
   {
       let headers: HTTPHeaders = [
                   /* "Authorization": "your_access_token",  in case you need authorization header */
                   "Content-type": "multipart/form-data"
               ]

                   AF.upload(
                       multipartFormData: { multipartFormData in
                           multipartFormData.append(self.imgView.image!.jpegData(compressionQuality: 0.5)!, withName: "upload" , fileName: file+".jpeg", mimeType: "image/jpeg")
                   },
                       to: "http://172.19.78.80:3000/upload", method: .post , headers: headers)
                       .response { resp in
                           print(resp)
                   }
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



