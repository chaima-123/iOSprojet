//
//  ServicePassword.swift
//  MiniProjet
//
//  Created by mac  on 14/12/2020.
//

import UIKit

class ServicePassword: NSObject {
    
    static let shared = ServicePassword()
    
    let baseUrl = "http://172.20.10.2:3000"

    func sendEmail (email: String, completion: @escaping(Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/authentification?email=\(email)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to send email:", err)
                    return
                }
                guard let data = data else { return }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }

    func updatePassword (id: Int, password:String, completion: @escaping(Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/updatePassword?id=\(id)&password=\(password)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to send email:", err)
                    return
                }
                guard let data = data else { return }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }

}
