//
//  ViewController.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/11/23.
//

import UIKit
import Alamofire

class ViewController: AppController {
    
    var users: [UserModel] = []
    
    private let viewModel: UserViewModel = UserViewModel()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        title = "User List"
        self.viewModel.delegate = self
        self.viewModel.loadData()


        // register tableview
        let nib = UINib(nibName: "UserTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showDetailScreen(user: UserModel){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyBoard.instantiateViewController(identifier: "TabbarViewController") as TabbarViewController
        tabbarVC.user = user
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.setUpCell(id: self.viewModel.getInfo(index: indexPath.row
                                                 ).id, name: self.viewModel.getInfo(index: indexPath.row
                                                                                   ).name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailScreen(user: self.viewModel.getInfo(index: indexPath.row))
    }
}

extension ViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            switch state {
            case .success:
                self.tableView.reloadData()
                self.stopLoading()
            case .idle:
                break
            case .loading:
                self.startLoading()
            case .error(let error):
                self.stopLoading()
                print(error)
            }
        }
    }
    
}
