//
//  Service.swift
//  MiniProjet
//
//  Created by mac  on 23/11/2020.
//

import UIKit

class Service: NSObject {

    static let shared = Service()
    
    let baseUrl = "http://172.20.10.2:3000"
    
    func fetchChauf(adress :String,completion: @escaping (Result<[User], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/showMenuisier?adress=\(adress)") else { return }
        
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
    
    func addUser(firstName: String,lastName: String,
                    email: String,   completion: @escaping (Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/addUser?firstName=\(firstName)&email=\(email)&lastName=\(lastName)") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
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
    
    func fetchElec(adress:String ,completion: @escaping (Result<[User], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/showElect?adress=\(adress)") else { return }
        
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
    
    
    func fetchPlomb(adress: String ,completion: @escaping (Result<[User], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/showPlomb?adress=\(adress)") else { return }
        
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
    
    
    
    func AddComment (idPres: Int,idUser: Int ,userName: String,
                     contenu: String, image:String, completion: @escaping (Result <Comment,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/addComment?idPrestataire=\(idPres)&idUser=\(idUser)&userName=\(userName)&contenu=\(contenu)&image=\(image)") else { return }
        
    
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to  add comment:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let user = try JSONDecoder().decode(Comment.self, from: data)
                    completion(.success(user))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        
        }.resume() // i always forget this
    }
    
    
    func ShowComments(idPres: Int,completion: @escaping (Result<[Comment], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/showComment?idPrestataire=\(idPres)") else { return }
        
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
                    let posts = try JSONDecoder().decode([Comment].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func UpdateComments(id: Int, contenu : String,completion: @escaping (Result<Comment, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/updateComment?id=\(id)&contenu=\(contenu)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to update comment:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode(Comment.self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func DeleteComment (id: Int, completion: @escaping (Result <String,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/deleteComment?id=\(id)") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to  delete comment:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    //let user = try JSONDecoder().decode(Comment.self, from: data)
                    completion(.success("OK"))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        
        }.resume() // i always forget this
    }
    
    func UpdateRate(idPres: Int, rate : Double,completion: @escaping (Result<User, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/rating?id=\(idPres)&rate=\(rate)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to update rate:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    
    func showChat(user1:String , user2:String ,completion: @escaping (Result<[Chat], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/findChat?user_name=\(user1)&rec=\(user2)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch messages:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode([Chat].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    
    func addChat(user1:String , user2:String , msg :String,isSent : Bool,completion: @escaping (Result<Chat, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/addChat?user_name=\(user1)&rec=\(user2)&text=\(msg)&is_sent_by_me=\(isSent)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch messages:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode(Chat.self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func updateStatus(userName:String,completion: @escaping (Result<[Chat], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/updateStatus?user_name=\(userName)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch messages:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode([Chat].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    
    
    func addService(client_id:Int, client_name:String , prestatire_id :Int, prestatire_name : String, type : String, description : String,completion: @escaping (Result<ServiceModel, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/demandeService?client_id=\(client_id)&client_name=\(client_name)&prestatire_id=\(prestatire_id)&prestatire_name=\(prestatire_name)&type=\(type)&description=\(description)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch messages:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode(ServiceModel.self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    
    
    func showService(prestataire_id: Int ,completion: @escaping (Result<[ServiceModel], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/showServicePro?prestatire_id=\(prestataire_id)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch services:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode([ServiceModel].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    
    func showServiceClient(client_id: Int ,completion: @escaping (Result<[ServiceModel], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/showServiceClient?client_id=\(client_id)") else { return }
        
        var fetchPostsRequest = URLRequest(url: url)
        fetchPostsRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: fetchPostsRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch services:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let posts = try JSONDecoder().decode([ServiceModel].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    

    func RefuserDemande (idService: Int, idPres: Int,completion: @escaping (Result <String,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/RefuserDemande?id=\(idService)&id=\(idPres)") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to  decline demand :", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    //let user = try JSONDecoder().decode(Comment.self, from: data)
                    completion(.success("OK"))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        
        }.resume() // i always forget this
    }
    
    func ConfirmerDemande (idService: Int, idPres: Int,completion: @escaping (Result <String,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/ConfirmerDemande?id=\(idService)&id=\(idPres)") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to  decline demand :", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    //let user = try JSONDecoder().decode(Comment.self, from: data)
                    completion(.success("OK"))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        
        }.resume() // i always forget this
    }

    func findUser (id : Int, completion: @escaping (Result <User,Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/findUser?id=\(id)") else { return }
        
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
