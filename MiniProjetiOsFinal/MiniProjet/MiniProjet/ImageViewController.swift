//
//  ImageViewController.swift
//  MiniProjet
//
//  Created by mac  on 04/12/2020.
//

import UIKit
import Alamofire


struct ImageResponse: Decodable
{
    let status: Int?
    let message: String?
}


class ImageViewController: UIViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   let url = URL(string: "http://localhost:3000/uploads/image.png")!
       //s imgView.loadImge(withUrl: url)
   }
    

    @IBAction func btnSelectImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                {
                    let myPickerController = UIImagePickerController()
                    myPickerController.delegate = self;
                    myPickerController.sourceType = .photoLibrary
                    self.present(myPickerController, animated: true, completion: nil)
                }
    }
    
    @IBAction func btnUpload(_ sender: Any)
    {
        let headers: HTTPHeaders = [
                    /* "Authorization": "your_access_token",  in case you need authorization header */
                    "Content-type": "multipart/form-data"
                ]

                    AF.upload(
                        multipartFormData: { multipartFormData in
                            multipartFormData.append(self.imgView.image!.jpegData(compressionQuality: 0.5)!, withName: "upload" , fileName: "file.jpeg", mimeType: "image/jpeg")
                    },
                        to: "http://172.19.78.80:3000/upload", method: .post , headers: headers)
                        .response { resp in
                            print(resp)


                    }
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
      
 }
    







