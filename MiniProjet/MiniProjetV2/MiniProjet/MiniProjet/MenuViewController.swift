//
//  MenuViewController.swift
//  MiniProjet
//
//  Created by mac  on 29/11/2020.
//

import UIKit

    enum MenuType: Int {
        case home
        case camera
        case profile
    }

    class MenuViewController: UITableViewController {

        var didTapMenuType: ((MenuType) -> Void)?

        override func viewDidLoad() {
            super.viewDidLoad()

        }
        

       
    }
