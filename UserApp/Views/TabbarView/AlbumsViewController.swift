//
//  AlbumsViewController.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/12/23.
//

import UIKit
import Alamofire

class AlbumsViewController: AppController {
    
    private let albumViewModel = AlbumViewModel()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tbvc = self.tabBarController as! TabbarViewController
        
        self.albumViewModel.delegate = self
        self.albumViewModel.loadData(userId: tbvc.user?.id ?? -1)
        
        // register tableview
        let nib = UINib(nibName: "UserTableViewCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
    }

}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.setUpCell(id: self.albumViewModel.getInfo(index: indexPath.row).id, name: self.albumViewModel.getInfo(index: indexPath.row).title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailVc = AlbumDetail()
        albumDetailVc.albumId = self.albumViewModel.getInfo(index: indexPath.row).id
        self.navigationController?.pushViewController(albumDetailVc, animated: true)
    }
    
}

extension AlbumsViewController: RequestDelegate {
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
