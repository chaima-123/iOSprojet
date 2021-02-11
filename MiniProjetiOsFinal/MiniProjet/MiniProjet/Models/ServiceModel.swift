//
//  ServiceModel.swift
//  MiniProjet
//
//  Created by mac  on 08/01/2021.
//

import Foundation
struct ServiceModel:Decodable{
   
    var _id:String
    var id: Int
    var  prestatire_id: Int
    var client_id: Int
    var client_name: String
    var prestatire_name: String
    var type:String
    var description :String
    var  etat:String
    var date_service:String

}
