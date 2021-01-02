//
//  Comment.swift
//  MiniProjet
//
//  Created by mac  on 10/12/2020.
//


import UIKit

    struct Comment:Decodable{
       
        var _id:String
        var id: Int
        var  idPrestataire: Int
        var idUser: Int
        var userName: String
        var dateCommentaire:String
        var contenu :String
        var  image:String
    }
