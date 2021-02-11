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

class ViewControllerInscri: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    var dataSource = [String]()
    var address:String = ""
    var test:Bool = false
    var testEmail:Bool = false


    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtConfPass: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtTel: UITextField!
        
    @IBOutlet weak var myView: UIView!
    
   
    @IBOutlet weak var btnInscri: UIButton!
    
    @IBOutlet weak var errorTel: UILabel!
    
    @IBOutlet weak var errorEmail: UILabel!
    
    @IBOutlet weak var errorMdp: UILabel!
    
    @IBOutlet weak var errorName: UILabel!
    
    @IBOutlet weak var errorMdp1: UILabel!
    
    @IBOutlet weak var errorMdp2: UILabel!
    
    @IBOutlet weak var errorPrenom: UILabel!
    
    @IBAction func btnSelectImage(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                {
                    let myPickerController = UIImagePickerController()
                    myPickerController.delegate = self;
                    myPickerController.sourceType = .photoLibrary
                    self.present(myPickerController, animated: true, completion: nil)
                }
    }
    
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
         let phoneNumberRegex = "^[259]\\d{7}$"
         let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
         let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
         let isValidPhone = validatePhone.evaluate(with: trimmedString)
         return isValidPhone
      }
      public func validateEmailId(emailID: String) -> Bool {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
         let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
         let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         let isValidateEmail = validateEmail.evaluate(with: trimmedString)
         return isValidateEmail
      }
    


  
    
    @objc fileprivate func handleCreatePost() {
        if (( txtFirstName.text!.isEmpty) && ( txtLastName.text!.isEmpty) )
             {
                 errorName.isHidden = false
                 errorName.text="Ce champ est obligatoire!"
                 
                 errorPrenom.isHidden = false
                 errorPrenom.text="Ce champ est obligatoire!"

            self.test = true

             }
             else{
                 errorName.isHidden = true
                 errorPrenom.isHidden = true
                self.test = false

             }
             
             
                 if((txtTel.text!.isEmpty))
                     {
                    self.test = true

                         errorTel.isHidden = false
                     errorTel.text="Ce champ est obligatoire!"}
                 
                 else if( validaPhoneNumber(phoneNumber: txtTel.text!) == false)
                 {
                     errorTel.isHidden = false
                     errorTel.text="Le numéro de téléphone doit se composé par 8 chiffres"
                    self.test = true

                }
                 else
                {
                 errorTel.isHidden = true
                    self.test = false

                }
             
             
             if((txtemail.text!.isEmpty))
                 {
                self.testEmail = true

                 errorEmail.isHidden = false
                 errorEmail.text="Ce champ est obligatoire!"}
             
             else if(  validateEmailId(emailID: txtemail.text!) == false  )
             {
              /**/
                self.testEmail = true
                 errorEmail.isHidden = false
                 errorEmail.text=" Adresse E-mail invalide"

                 
             }
             else
            {
             errorEmail.isHidden = true
                self.testEmail = false
            }
        

        if(txtPassword.text!.isEmpty )
        {
            errorMdp1.isHidden = false
            errorMdp1.text = "Ce champ est obligatoire!"
            self.test = true
        }
        else {
            errorMdp1.isHidden = true
            self.test = false
            
        }
        
        if( txtConfPass.text!.isEmpty)
        {
        errorMdp2.isHidden = false
        errorMdp2.text = "Ce champ est obligatoire!"
        self.test = true

        }
        else if ( txtPassword.text! != txtConfPass.text!)
        {
            errorMdp2.isHidden = false
            errorMdp2.text = "Mots de passe incompatibles"
            self.test = true

        }
        else
        {
            errorMdp1.isHidden = true
            errorMdp2.isHidden = true
               self.test == false
        }
        
        
        
        if(test == false && testEmail == false)
        {Service.shared.createUser(firstName: txtFirstName.text!,
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
                print(user)
                self.toastMessage(user.message)
                let alert = UIAlertController(title: "Sucées", message:  "Un email de confirmation vient de vous être envoyé.Relevez votre courrier pour valider votre inscription", preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Fermer", style: UIAlertAction.Style.cancel, handler: { [self]
                                    action in
                    let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController
                                        newViewController?.modalPresentationStyle = .fullScreen
                                        self.present(newViewController!, animated:true, completion:nil)
                                })
                                alert.addAction(closeAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
            
        
        
 
 
   }
        
    }

    @IBAction func subscribe(_ sender: Any) {
     
      
        handleCreatePost()
    }
    
    


    
    
    @IBOutlet weak var imgView: UIImageView!
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()

    override func viewDidLoad()
    {
        super.viewDidLoad()
  
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
       
        
      //  btnInscri.applyGradient(colours: [., .systemPurple])
        btnInscri.layer.masksToBounds = true
        btnInscri.layer.cornerRadius = 20
    
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
                   "Content-type": "multipart/form-data"]

                   AF.upload(
                       multipartFormData: { multipartFormData in
                           multipartFormData.append(self.imgView.image!.jpegData(compressionQuality: 0.5)!, withName: "upload" , fileName: file+".jpeg", mimeType: "image/jpeg")
                   },
                       to: "http://192.168.0.3:3000/upload", method: .post , headers: headers)
                       .response
                    { resp in
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



