//
//  CommentsViewController.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/13/23.
//

import UIKit
import Alamofire

class CommentsViewController: AppController {

    @IBOutlet weak var tableview: UITableView!
    
    private let commentsViewModel = CommentViewModel()

    var postId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsViewModel.delegate = self
        commentsViewModel.loadData(id: self.postId ?? -1)
        
        // register tableview
        let nib = UINib(nibName: "CommentTableViewCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
    }

}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentsViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentTableViewCell
        
        cell.setUpView(comment: self.commentsViewModel.getInfo(index: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select \(indexPath)")
    }
}

extension CommentsViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            switch state {
            case .success:
                self.tableview.reloadData()
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
