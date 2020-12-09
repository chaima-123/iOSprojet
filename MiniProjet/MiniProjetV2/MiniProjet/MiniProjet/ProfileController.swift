//
//  ProfileController.swift
//  MiniProjet
//
//  Created by mac  on 06/12/2020.
//

import UIKit

class ProfileController: UIViewController {
    var user:User?

    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var btnCommentaire: UIButton!
    @IBOutlet weak var btnRatingShow: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: "id_user")!)
        
       // print(user!.firstName+"hiiiiiii "+user!.email)
        labelName.text = user!.firstName+" "+user!.lastName
        
        self.btnCommentaire.applyGradient(colours: [.purple, .systemPurple])
        btnCommentaire.layer.masksToBounds = true
        btnCommentaire.layer.cornerRadius = 20

        let url = URL(string: "http://localhost:3000"+user!.image)!
        imgView.loadImge(withUrl: url)
        btnRatingShow.layer.masksToBounds = true

        self.btnRatingShow.applyGradient(colours: [.purple, .systemPurple])

        self.btnRatingShow.layer.cornerRadius = 20
       // self.btnCommentaire.corner

        // Do any additional setup after loading the view.
    }

}

