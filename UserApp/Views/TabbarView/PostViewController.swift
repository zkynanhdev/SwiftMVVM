//
//  PostViewController.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/12/23.
//

import UIKit
import Alamofire

class PostViewController: AppController {
 
    private let postViewModel = PostViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tbvc = self.tabBarController as! TabbarViewController
        postViewModel.delegate = self
        postViewModel.loadData(id: tbvc.user?.id ?? -1)
        
        // register tableview
        let nib = UINib(nibName: "PostTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        cell.setUpCell(post: self.postViewModel.getInfo(index: indexPath.row))
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select \(indexPath)")
//        let albumDetailVc = AlbumDetail()
//        albumDetailVc.albumId = albums[indexPath.row].id
//        self.navigationController?.pushViewController(albumDetailVc, animated: true)
    }
}

extension PostViewController: PostCellDelegate {
    func cellCommentButtonTapped(cell: PostTableViewCell) {
        let indexPath = self.tableView.indexPath(for: cell)!
        let commentVc = CommentsViewController()
        commentVc.postId = self.postViewModel.getInfo(index: indexPath.row).id
        self.present(commentVc, animated: true)
    }
    
}

extension PostViewController: RequestDelegate {
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


