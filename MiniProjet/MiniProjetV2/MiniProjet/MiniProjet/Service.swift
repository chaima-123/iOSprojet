//
//  Service.swift
//  MiniProjet
//
//  Created by mac  on 23/11/2020.
//

import UIKit

class Service: NSObject {

    static let shared = Service()
    
    let baseUrl = "http://172.19.78.80:3000"
    
    func fetchPosts(completion: @escaping (Result<[User], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/showPrestataire") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch posts:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func createUser(firstName: String,lastName: String,
                    email: String,tel:String, password:String,city:String,
                    completion: @escaping (Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/usercheck?firstName=\(firstName)&email=\(email)&lastName=\(lastName)&tel=\(tel)&password=\(password)&city=\(city)") else { return }
        

        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch posts:", err)
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
        
        }.resume() // i always forget this
        
    }
    
    
    
    func deletePost(id: Int, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "\(baseUrl)/post/\(id)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(err)
                    return
                }
                
                if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                    let errorString = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    completion(NSError(domain: "", code: resp.statusCode, userInfo: [NSLocalizedDescriptionKey: errorString]))
                    return
                }
                
                completion(nil)
                
            }
            // check error
            
        }.resume() // i always forget this
    }


func login (email: String,password: String, completion: @escaping(Result <User,Error>) -> ()) {
    guard let url = URL(string: "\(baseUrl)/loginn?email=\(email)&password=\(password)") else { return }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"

    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
        DispatchQueue.main.async {
            if let err = err {
                print("Failed to fetch posts:", err)
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
        
    func lastRecord ( completion: @escaping(Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/lastRecord") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get last record:", err)
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
    
    
    func updateUser (id : Int,firstName: String,lastName: String,
                     email: String,tel:String, completion: @escaping (Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/updateUser?id=\(id)&firstName=\(firstName)&email=\(email)&lastName=\(lastName)&tel=\(tel)") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to  update:", err)
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
        
        }.resume() // i always forget this
    }
    
    
    func updateRole (id : Int,profession: String,desc: String,
                     completion: @escaping (Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/updateRole?id=\(id)&profession=\(profession)&description=\(desc)") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to  update:", err)
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
        
        }.resume() // i always forget this
    }
    

}
