//
//  ShowViewController.swift
//  MiniProjet
//
//  Created by mac  on 23/11/2020.
//

import UIKit

class ShowViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
  
    var mang:[User] = []
    var user:User?
    
    @objc fileprivate func fetchPosts() {
        Service.shared.fetchPosts { (res) in
            self.myTable.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let mang):
//                print(posts)
                self.mang = mang
                self.myTable.reloadData()
                print(mang)
            }
        }
    }
  

    @IBAction func loadSv(_ sender: Any) {
        fetchPosts()
        //  handleCreatePost()
        
        
        
        
        
        /*
        let url = URL(string: "http://192.168.0.4:3000/showAll")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let tasks = URLSession.shared.dataTask(with: request){ data , response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                print("error", error ?? "tag")
                return
            
            }
            let dataString = String (data:data , encoding: String.Encoding.utf8)
            print(dataString)
            let JsonDecoder = JSONDecoder()
            do {
                let users = try JsonDecoder.decode([User].self, from: data)
                self.mang = users
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
            } catch { print(error) }
        }
        
        tasks.resume()*/
        
    }
    
    

    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = myTable.dequeueReusableCell(withIdentifier: "CELL") as! ShowTableViewCell
        cell.labelEmail.text = mang[indexPath.row].firstName
        cell.labelFirstName.text = mang[indexPath.row].email
        return cell
    }
    

}
