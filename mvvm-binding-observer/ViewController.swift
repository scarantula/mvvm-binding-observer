//
//  ViewController.swift
//  mvvm-binding-observer
//
//  Created by user205198 on 11/2/21.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        viewModel.users.bind { [weak self] _ in
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()
            }
        }
        
        fetchData()
    }
    
    func fetchData(){
        APIManager.singleton.callAPIRequest(url: "https://jsonplaceholder.typicode.com/users") { responseJSON in
            self.jsonHandler(responseJSON)
        } errorCompletion: { error in
            print("Error occured whilemaking API request, \(error.localizedDescription)")
        }
    }
    
    func jsonHandler(_ json: JSON){
        
        viewModel.users.value = json.compactMap({ (_, jsonData) in
            UserCellViewModel(json: jsonData)
        })
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.users.value ?? "nil")
        return viewModel.users.value?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.users.value?[indexPath.row].name ?? "No Name"
        return cell
    }
}

